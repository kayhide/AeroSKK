guard 'motion' do
  watch(%r{^spec/.+_spec\.rb$})

  watch('Rakefile')               { Dir["spec/**/*.rb"] }
  watch(%r{^app/(.+)\.rb$})       { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/[^/]+/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
end
