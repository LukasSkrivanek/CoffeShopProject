Pod::Spec.new do |s|
  s.name = 'Utilities'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'Some summary'
  s.homepage = 'https://github.com/later'
  s.source = { :git => 'https://github.com/LukasSkrivanek/CoffeShopProject.git', :tag => '1.0.0' }

  s.ios.deployment_target = '17.0'

  s.source_files = 'Sources/*.swift'

  s.swift_versions = ['5.9']
end