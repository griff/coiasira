module Coiasira
  module Jobs
    # The root paths which may contain job files
    mattr_accessor :job_paths
    self.job_paths = []
    
    class << self
    # Returns an array of paths, cleaned of double-slashes and relative path references.
    # * "\\\" and "//"  become "\\" or "/". 
    # * "/foo/bar/../config" becomes "/foo/config".
    # The returned array is sorted by length, descending.
      def normalize_paths(paths)
        # do the hokey-pokey of path normalization...
        paths = paths.collect do |path|
          path = path.
            gsub("//", "/").           # replace double / chars with a single
            gsub("\\\\", "\\").        # replace double \ chars with a single
            gsub(%r{(.)[\\/]$}, '\1')  # drop final / or \ if path ends with it

          # eliminate .. paths where possible
          re = %r{[^/\\]+[/\\]\.\.[/\\]}
          path.gsub!(re, "") while path.match(re)
          path
        end

        # start with longest path, first
        paths = paths.uniq.sort_by { |path| - path.length }
      end

    # Returns the array of job names currently available.
      def possible_jobs
        unless @possible_jobs
          @possible_jobs = []

          paths = job_paths.select { |path| File.directory?(path) && path != "." }

          seen_paths = Hash.new {|h, k| h[k] = true; false}
          normalize_paths(paths).each do |load_path|
            Dir["#{load_path}/**/*_job.rb"].collect do |path|
              next if seen_paths[path.gsub(%r{^\.[/\\]}, "")]

              job_name = path[(load_path.length + 1)..-1]

              job_name.gsub!(/_job\.rb\Z/, '')
              @possible_jobs << job_name
            end
          end

          # remove duplicates
          @possible_jobs.uniq!
        end
        @possible_jobs
      end
      
      def has_job?(name)
        possible_jobs.include?(name)
      end
            
      def load_job(name)
        raise NameError, name unless has_job?(name)
        
        paths = job_paths.select { |path| File.directory?(path) && path != "." }
        path = normalize_paths(paths).find {|load_path| ::File.exists?("#{load_path}/#{name}_job.rb") }
        job_file = "#{path}/#{name}_job.rb"
        data = IO.read(job_file)
        JobWrapper.new(name, data, job_file)
      end
    
      def find_class(name)
        "Coiasira::JobWrapper::#{name.camelize}Job".constantize
      end
    end
  end
end