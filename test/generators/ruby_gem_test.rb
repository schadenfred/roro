require "test_helper"

describe Roro::CLI do

  Given(:subject) { Roro::CLI.new }

  Given { prepare_destination 'dummy_gem' }

  describe ":ruby_gem" do

    describe "default" do

      Given { subject.ruby_gem }
      Given(:expected) { YAML.load_file('../../test/fixtures/files/docker-compose.yml' ) }

      Then do

        assert_file 'docker-compose.yml'
        assert_equal YAML.load_file('docker-compose.yml'), expected
        # assert_file 'docker-compose.yml', /\tapp-2-5-3:/

        assert_file '.circleci'
        assert_file '.circleci/config.yml'
        assert_file '.circleci/setup-gem-credentials.sh'

        assert_file 'docker'

        assert_file 'docker/containers'

        assert_file 'docker/containers/app'
        assert_file 'docker/containers/app/Dockerfile', /ruby:2.5-alpine/
        assert_file 'docker/containers/2-5-1/Dockerfile'
        assert_file 'docker/containers/2-5-3/Dockerfile', /ruby:2.5.3-alpine/
      end

      # describe ":ruby_gem" do
      #
      #   describe "default" do
      #
      #     Given { subject.ruby_gem }
      #
      #     Then do
      #
      #       assert_file 'docker-compose.yml', /app:/
      #
      #       assert_file '.circleci'
      #       assert_file '.circleci/config.yml'
      #       assert_file '.circleci/setup-gem-credentials.sh'
      #
      #       assert_file 'docker'
      #
      #       assert_file 'docker/containers'
      #
      #       assert_file 'docker/containers/app'
      #       assert_file 'docker/containers/app/Dockerfile'
      #     end
    end
  end
end