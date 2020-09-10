require 'roro/cli/stories/configurator'
require 'roro/cli/stories/dependencies'
require 'roro/cli/stories/okonomi'
require 'roro/cli/generate/config/story'
require 'roro/cli/generate/config/structure'
require 'roro/cli/generate/exposed'
require 'roro/cli/generate/keys'
require 'roro/cli/generate/obfuscated'
require 'roro/cli/greenfield/rails'
require 'roro/cli/rollon'
require 'roro/cli/rollon/rails/base/base'
require 'roro/cli/rollon/rails/database/with_mysql'
require 'roro/cli/rollon/rails/database/with_postgresql'
require 'roro/cli/rollon/rails/kubernetes'

require 'roro/cli/rollon/ruby_gem'

module Roro
  
  class CLI < Thor

    include Thor::Actions
    
    def self.source_root
      File.dirname(__FILE__) + '/cli/templates'
    end    
  end
end
