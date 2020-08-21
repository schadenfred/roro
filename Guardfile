# A sample Guardfile
# More info at https://github.com/guard/guard#readme

options = {
  cli: '-f',
  all_on_start: true,
  all_after_pass: false
}

guard :minitest, options do

  watch(%r{^test/(.*)\/?test_(.*)\.rb$})
  watch(%r{^test/(.*)\/?(.*)_test\.rb$})
  watch(%r{^lib/roro/(.+)\.rb$}) { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^test/thor_helper\.rb$})      { 'test' }
  watch(%r{^test/fixtures/files/(.*/)?([^/]+)\.yml$})     { 'test' }
end
