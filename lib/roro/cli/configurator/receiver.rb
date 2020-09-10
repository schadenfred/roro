
module Roro
  module Receiver 
    
    def initialize(options=nil)
      options ||= {}
      options[:story] ||=  { rails: {} } 
      sanitize(options)
      @structure = {
        choices:    {},
        env_vars:   {},
        intentions: {}, 
        story:      {} 
      }
      build_layers(stories: @options[:story])
      @intentions = @structure[:intentions]
      @env = @structure[:env_vars]
      @env[:main_app_name] = Dir.pwd.split('/').last 
      @env[:ruby_version] = RUBY_VERSION
      screen_target_directory 
    end
  end 
end