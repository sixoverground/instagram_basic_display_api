Gem::Specification.new do |s|
  s.name = %q{instagram_basic_display_api}
  s.version = "0.0.0"
  s.date = %q{2020-03-05}
  s.summary = %q{Instagram Basic Display API}
  s.files = [
    "lib/instagram_basic_display_api.rb"
  ]
  s.require_paths = ["lib"]
  s.authors = ["Craig Phares"]
  s.licenses = ['MIT']
  s.email = ['craig@sixoverground.com']
  s.homepage = 'https://github.com/sixoverground/instagram_basic_display_api'
  s.add_runtime_dependency('faraday', ['>=1.0.0', '<= 1.0.0'])
end