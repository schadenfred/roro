module Roro
  class CLI < Thor
    
    desc "generate::keys", "Generates a key for each <environment>.env file."
    method_option :environment, type: :hash, default: {}, desc: "Generates a key for each argument.", banner: "development, staging"
    
    map "generate::keys" => "generate_keys"
    map "generate::key"  => "generate_keys"
    map "generate:keys"  => "generate_keys"
    map "generate:key"   => "generate_keys"

    def generate_keys(*environments)
      key_writer = Roro::Crypto::KeyWriter.new
      key_writer.write_keyfiles(environments, './roro', '.env')
    end
  end
end