module Rails
  class Initializer
    def initialize_quartz
      return unless configuration.frameworks.include?(:quartz)
      Quartz::Jobs.job_paths = configuration.job_paths
#    ActionController::Routing::Routes.configuration_file = configuration.routes_configuration_file
#    ActionController::Routing::Routes.reload
    end
        
    def initialize_routing_with_quartz
      initialize_routing_without_quartz
      initialize_quartz
    end
    alias_method_chain :initialize_routing, :quartz
  end
  
  class Configuration
    attr_accessor :quartz

    # The list of paths that should be searched for jobs. (Defaults
    # to <tt>app/jobs</tt>.)
    attr_accessor :job_paths

    def initialize_with_quartz
      initialize_without_quartz
      self.job_paths = default_job_paths
    end
    alias_method_chain :initialize, :quartz

  private
    def default_frameworks_with_quartz
      default_frameworks_without_quartz + [ :quartz ]
    end
    alias_method_chain :default_frameworks, :quartz
    
    def default_load_paths_with_quartz
      paths = default_load_paths_without_quartz
      
      # Add the app's job directory
      paths.concat(Dir["#{root_path}/app/jobs/"])
    end
    alias_method_chain :default_load_paths, :quartz

    def default_job_paths
      [File.join(root_path, 'app', 'jobs')]
    end
  end
end