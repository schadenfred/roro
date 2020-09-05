require "test_helper"

describe "Story::Rails::WithCICD" do 

  Given { prepare_destination 'rails/603' }
  Given { stub_system_calls }

  Given(:config)  { Roro::Configurator.new }
  Given { config.env['force'] = true}  
  Given(:subject) { Roro::CLI.new }
  Given(:rollon)  { 
    subject.instance_variable_set(:@config, config)
    subject.rollon_rails
  }
  
  Given { rollon }
  
  describe '.circleci/config.yml' do 
    
    Given(:file) { '.circleci/config.yml' }
    
    Then { assert_directory ".circleci" }
        
    describe 'must have the correct structure' do
          
      Given(:structure) { YAML.load_file('.circleci/config.yml')}
          
      Then { 
        assert_includes structure.keys, 'version' 
        assert_includes structure.keys, 'defaults' 
        assert_includes structure.keys, 'major_only' 
        assert_includes structure.keys, 'executors' 
        assert_includes structure.keys, 'commands' 
        assert_includes structure.keys, 'jobs' 
        assert_includes structure.keys, 'workflows' 
        assert structure['jobs']['build'] 
        assert structure['jobs']['test'] 
        assert structure['jobs']['push'] 
        assert structure['workflows']['build-test-push'] 
      }
    end 
  end
end