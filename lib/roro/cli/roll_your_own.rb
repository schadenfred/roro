module Roro

  class CLI < Thor

    desc 'rollyourown', "Roll your own RoRo development story."

    map 'roll_your_own' => 'roll_your_own'

    attr_reader :config, :story

    def roll_your_own
      @config = Roro::Configurators::Configurator.new
      @config.roll_your_own
      @story = @config.story
    end
  end
end