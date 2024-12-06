Gem::Specification.new do |s|
  s.name = 'instagram_basic_display_api'
  s.version = '0.0.3'
  s.date = '2024-12-05'
  s.summary = 'Instagram Basic Display API'
  s.files = Dir['{lib,spec}/**/*']
  s.require_paths = ['lib']
  s.authors = ['Craig Phares']
  s.licenses = ['MIT']
  s.email = ['craig@sixoverground.com']
  s.homepage = 'https://github.com/sixoverground/instagram_basic_display_api'

  s.add_runtime_dependency('faraday', '>= 0.17.3', '< 2.8.0')
  s.add_runtime_dependency('faraday_middleware', '>= 0.14', '< 1.3')

  s.add_development_dependency('dotenv', '~> 2.7', '>= 2.7.5')
  s.add_development_dependency('rspec', '~> 3.9', '>= 3.9.0')
end
