require 'test_helper'

describe Roro::Configuration::Receiver do

  Given { greenfield_rails_test_base }
  Given(:options) { nil }
  Given(:config) { Roro::Configuration.new(options) }
    
  describe 'sanitizing options when options contain' do

    Given(:expected) { { story: :rails } }
    Given(:actual) { config.sanitize(options) }
    
    describe 'properly formatted' do 
      
      Given(:options) { expected }
      
      Then { assert_equal expected, actual }
    end
    
    describe 'nested hashes' do 
        
      Given(:options) { { story: :rails } }
      
      Then { assert_equal expected, actual }
    end
    
    describe 'nil' do 
        
      Given(:expected) { {} }
      Given(:options) { nil }
      
      Then { assert_equal expected, actual }
    end
    
    describe 'symbols' do

      Given(:options) { { story: :rails } }
      
      Then { assert_equal expected, actual }
    end
    
    describe 'strings' do

      Given(:options) { { 'story' =>  'rails' } }
      
      Then { assert_equal expected, actual }
    end
    
    describe 'booleans' do

      Given(:options)  { { story: { rails: true } } }
      Given(:expected) { options }
      
      Then { assert_equal expected, actual }
    end
    
    describe 'contains arrays' do 

      Given(:expected) { { story: { rails: [
        { database: { postgresql: {} }},
        { ci_cd:    { circleci:   {} }}
      ] } } }

      Given(:options) { { story: { rails: [
        { database: { 'postgresql' => {} }},
        { ci_cd:    { circleci:   {} }}
      ] } } }
      
      Given(:expected)  { options }
   
      Then { assert_equal expected, actual } 
    end
  end
  
  describe '.story_map' do 
    describe 'rollon' do 
      Given(:story_map) { [
        { rails: [
          { database: [
            { postgresql: [] },
            { mysql: [] }
          ] },
          { ci_cd: [
            { circleci: [] }
          ] },
          { kubernetes: [
            { postgresql: [
              { edge: [] }, 
              { default: [] }
            ] }
          ] }
        ]}, 
        { ruby_gem: []}
      ]}

      Then { assert_equal( story_map, config.story_map(:rollon) )}
    end
  end
  
  describe 'story' do 
    
    Given(:default_story)  { 
      { rollon: 
        { rails: [
          { database: :postgresql },
          { ci_cd: :circleci },
          { kubernetes: :postgresql }
    ] } } }
    
    describe '.default_story' do 
      
      Given(:expected)  { default_story} 
      
      Then { assert_equal expected, config.default_story }
      And  { assert_equal expected, config.story }
    end
    
    describe 'custom story' do 

      describe 'when same as default_story' do 
      
        Given(:options)  { 
          { story: 
            { rails: [
              { database: :postgresql },
              { ci_cd: :circleci },
              { kubernetes: :postgresql }
        ] } } }
  
        Given(:expected)  { default_story} 
        
        Then  { assert_equal default_story, config.story }
      end
      
      describe 'when different substory' do 
        
        Given(:options)  { 
          { story: 
            { rails: [
              { database: :mysql },
              { ci_cd: :circleci },
              { kubernetes: :postgresql }
        ] } } }

        Given(:expected)  { default_story} 
        
        Then { assert_equal options[:story], config.story[:rollon] }
      end
    end
    
    describe 'story not recognized' do 

      Given(:options) { { story: :nostory} }
    
      Then  { assert_raises(  Roro::Error  ) { config } }
    end
  end
end    
