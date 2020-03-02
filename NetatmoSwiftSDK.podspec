Pod::Spec.new do |s|
  s.name = 'NetatmoSwiftAPI'
  s.version = '0.0.1'
  s.license = 'MIT'
  s.summary = 'NetatmoSwiftSDK is a Swift wrapper around the Netatmo API.'
  s.homepage = 'https://github.com/Baza207/NetatmoSwiftSDK'
  s.authors = { 'James Barrow' => 'james@pigonahill.com' }
  s.source = { :git => 'https://github.com/Baza207/NetatmoSwiftSDK.git', :tag => s.version }
  s.documentation_url = 'https://github.com/Baza207/NetatmoSwiftSDK/README.md'
  s.ios.deployment_target = '12.0'
  s.swift_versions = ['5.0', '5.1']
  s.source_files = 'Source/*.swift'
end
