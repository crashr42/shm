# A sample Guardfile
# More info at https://github.com/guard/guard#readme

notification :libnotify, :timeout => 1, :transient => true, :append => false, :urgency => :critical

guard 'jasmine' do
  watch(%r{spec/javascripts/spec\.(js\.coffee|js|coffee)$})         { "spec/javascripts" }
  watch(%r{spec/javascripts/.+_spec\.(js\.coffee|js|coffee)$})
  watch(%r{app/assets/javascripts/(.+?)\.(js\.coffee|js|coffee)$})  { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
end

guard :coffeescript, :all_on_start => true, :output => 'public/javascripts/compiled' do
  watch(%r{(.+\.coffee)})
end