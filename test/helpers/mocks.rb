module TestHelper
  module Mocks
    module Stubs 
      def stubs_system_calls
        Roro::CLI.any_instance.stubs(:system) 
      end
      
      def stubs_asker 
        asker = Thor::Shell::Basic.any_instance
        asker.stubs(:ask).returns('y') 
      end
      
      def stubs_startup_commands
        Roro::CLI.any_instance.stubs(:startup_commands) 
      end
      
      def stubs_congratulations 
        Roro::CLI.any_instance.stubs(:congratulations) 
      end 
      
      def stubs_manifests
        Roro::CLI.any_instance.stubs(:manifest_actions) 
        Roro::CLI.any_instance.stubs(:manifest_intentions) 
      end
    
      def stubs_dependency_responses 
        Roro::Configuration.any_instance.stubs(:screen_target_directory)
      end
      
      def io_confirm 
        IO.stubs(:popen).returns([]) 
      end
      
      def io_deny
        IO.stubs(:popen).returns([1]) 
      end
    end 
  end
end