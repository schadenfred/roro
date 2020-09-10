require 'roro/cli/rollon/stories'
require 'roro/cli/rollon/rails/database'

module Roro

  class CLI < Thor
        
    desc "rollon::rails", "Generates files for and makes changes to your app 
      so it can run using Docker containers."
    method_option :interactive, desc: "Set up your environment variables as 
      you go."
    map "rollon::rails" => "rollon_rails"
    
    def rollon_rails(options={}) 
      options.merge!({ story: { rails: [
        { database: { postgresql: {} }},
        { ci_cd:    { circleci:   {} }}
      ] } } )
      
      configure_for_rollon(options)
      @config.structure[:actions].each {|a| eval a }
      execute_intentions
      startup_commands
    end
    
    no_commands do
                      
      def startup_commands
        success_msg = "Your Rails app is available at http://localhost:3000/"
        system 'docker-compose build --no-cache'
        system 'docker-compose run app bin/rails db:create'
        system 'docker-compose run app bin/rails db:migrate'
        system "docker-compose run app echo #{success_msg}"
      end
    end
  end
end