require 'byebug'
require 'handsome_fencer/crypto'

module Roro

  class CLI < Thor

    include Thor::Actions
    include HandsomeFencer::Crypto

    desc "obfuscate", "obfuscates any files matching the pattern ./docker/**/*.env"

    def obfuscate(*args)
      default_environments = %w[circleci development staging production]
      environments = args.first ? [args.first] : default_environments
      environments.each do |environment|
        # byebug
        HandsomeFencer::Crypto.obfuscate(environment, '.')
      end
    end
  end
end