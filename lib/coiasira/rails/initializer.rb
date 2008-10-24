module Rails
  class Initializer
    def self.alias_method_chain(target, feature)
      # Strip out punctuation on predicates or bang methods since
      # e.g. target?_without_feature is not a valid method name.
      aliased_target, punctuation = target.to_s.sub(/([?!=])$/, ''), $1
      yield(aliased_target, punctuation) if block_given?

      with_method, without_method = "#{aliased_target}_with_#{feature}#{punctuation}", "#{aliased_target}_without_#{feature}#{punctuation}"

      alias_method without_method, target
      alias_method target, with_method

      case
        when public_method_defined?(without_method)
          public target
        when protected_method_defined?(without_method)
          protected target
        when private_method_defined?(without_method)
          private target
      end
    end
    
    def initialize_coiasira
      return unless configuration.frameworks.include?(:coiasira)
      ::Coiasira::Jobs.job_paths = configuration.job_paths
#    ActionController::Routing::Routes.configuration_file = configuration.routes_configuration_file
#    ActionController::Routing::Routes.reload
    end
        
    def initialize_routing_with_coiasira
      initialize_routing_without_coiasira
      initialize_coiasira
    end
    alias_method_chain :initialize_routing, :coiasira
  end
  
  class Configuration
    def self.alias_method_chain(target, feature)
      # Strip out punctuation on predicates or bang methods since
      # e.g. target?_without_feature is not a valid method name.
      aliased_target, punctuation = target.to_s.sub(/([?!=])$/, ''), $1
      yield(aliased_target, punctuation) if block_given?

      with_method, without_method = "#{aliased_target}_with_#{feature}#{punctuation}", "#{aliased_target}_without_#{feature}#{punctuation}"

      alias_method without_method, target
      alias_method target, with_method

      case
        when public_method_defined?(without_method)
          public target
        when protected_method_defined?(without_method)
          protected target
        when private_method_defined?(without_method)
          private target
      end
    end

    attr_accessor :coiasira

    # The list of paths that should be searched for jobs. (Defaults
    # to <tt>app/jobs</tt>.)
    attr_accessor :job_paths

    def initialize_with_coiasira
      initialize_without_coiasira
      self.job_paths = default_job_paths
    end
    alias_method_chain :initialize, :coiasira

  private
    def default_frameworks_with_coiasira
      default_frameworks_without_coiasira + [ :coiasira ]
    end
    alias_method_chain :default_frameworks, :coiasira
    
    def default_load_paths_with_coiasira
      paths = default_load_paths_without_coiasira
      
      # Add the app's job directory
      paths.concat(Dir["#{root_path}/app/jobs/"])
    end
    alias_method_chain :default_load_paths, :coiasira

    def default_job_paths
      [File.join(root_path, 'app', 'jobs')]
    end
  end
end