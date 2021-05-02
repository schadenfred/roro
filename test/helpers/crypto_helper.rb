module TestHelper
  module Helpers
    module Crypto
      def insert_decryptable_file(filename='dummy.env.enc') 
        directory   ||= './roro'
        destination ||= "#{directory}/#{filename}"
        insert_file 'dummy_env', destination
      end
      
      def insert_dummy_encryptable(filename='./roro/dummy.env') 
        insert_dummy(filename) 
      end
      
      def insert_dummy_decryptable(filename='./roro/dummy.env.enc') 
        insert_file 'dummy_env_enc', filename 
      end
      
      def insert_dummy(filename='./roro/dummy.env')
        insert_file 'dummy_env', filename
      end
      
      def insert_key_file(filename='dummy.key')
        insert_file 'dummy_key', "./roro/keys/#{filename}"
      end
        
      def assert_correct_error
        returned = assert_raises(error) { execute }
        assert_match error_message, returned.message 
      end 
      
      def assert_destruction_error 
        assert_correct_error
      end
      
      def assert_correctly_written
        execute
        assert_equal File.read(destination), content 
      end    
      
      def assert_correctly_sourced
        insert_dummy
        assert_includes execute, source_file 
      end 
      
      def assert_correctly_gathered 
        insert_dummy
        assert_equal ['dummy'], execute
      end
    
    end 
  end 
end