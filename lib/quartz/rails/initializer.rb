module Rails
  class Initializer
    def initialize_quartz
      return unless configuration.frameworks.include?(:quartz)
      Quartz::Jobs.job_paths = configuration.job_paths
#    ActionController::Routing::Routes.configuration_file = configuration.routes_configuration_file
#    ActionController::Routing::Routes.reload
    end
    
    # Sequentially step through all of the available initialization routines,
    # in order (view execution order in source).
    def process
      Rails.configuration = configuration

      check_ruby_version
      install_gem_spec_stubs
      set_load_path
      
      require_frameworks
      set_autoload_paths
      add_gem_load_paths
      add_plugin_load_paths
      load_environment

      initialize_encoding
      initialize_database

      initialize_cache
      initialize_framework_caches

      initialize_logger
      initialize_framework_logging

      initialize_framework_views
      initialize_dependency_mechanism
      initialize_whiny_nils
      initialize_temporary_session_directory
      initialize_time_zone
      initialize_framework_settings

      add_support_load_paths

      load_gems
      load_plugins

      # pick up any gems that plugins depend on
      add_gem_load_paths
      load_gems
      check_gem_dependencies
      
      load_application_initializers

      # the framework is now fully initialized
      after_initialize

      # Prepare dispatcher callbacks and run 'prepare' callbacks
      prepare_dispatcher

      # Routing must be initialized after plugins to allow the former to extend the routes
      initialize_routing

      initialize_quartz
      
      # Observers are loaded after plugins in case Observers or observed models are modified by plugins.
      
      load_observers
    end
  end
  
  class Configuration
    attr_accessor :quartz

    # The list of paths that should be searched for jobs. (Defaults
    # to <tt>app/jobs</tt>.)
    attr_accessor :job_paths

    def initialize
      set_root_path!

      self.frameworks                   = default_frameworks
      self.load_paths                   = default_load_paths
      self.load_once_paths              = default_load_once_paths
      self.log_path                     = default_log_path
      self.log_level                    = default_log_level
      self.view_path                    = default_view_path
      self.controller_paths             = default_controller_paths
      self.job_paths                    = default_job_paths
      self.cache_classes                = default_cache_classes
      self.whiny_nils                   = default_whiny_nils
      self.plugins                      = default_plugins
      self.plugin_paths                 = default_plugin_paths
      self.plugin_locators              = default_plugin_locators
      self.plugin_loader                = default_plugin_loader
      self.database_configuration_file  = default_database_configuration_file
      self.routes_configuration_file    = default_routes_configuration_file
      self.gems                         = default_gems

      for framework in default_frameworks
        self.send("#{framework}=", Rails::OrderedOptions.new)
      end
      self.active_support = Rails::OrderedOptions.new
    end

  private
    def default_frameworks
      [ :active_record, :action_controller, :action_view, :action_mailer, :active_resource, :quartz ]
    end

    def default_job_paths
      [File.join(root_path, 'app', 'jobs')]
    end
  end
end