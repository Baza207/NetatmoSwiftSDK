Pod::Spec.new do |spec|
  spec.name = 'NetatmoSwiftSDK'
  spec.version = '0.0.1'
  spec.license = 'MIT'
  spec.homepage = 'https://github.com/Baza207/NetatmoSwiftSDK'
  spec.authors = { 'James Barrow' => 'james@pigonahill.com' }
  spec.summary = 'NetatmoSwiftSDK is a Swift wrapper around the Netatmo API.'
  spec.source = { :git => 'https://github.com/Baza207/NetatmoSwiftSDK.git', :tag => spec.version }
  spec.ios.deployment_target = '12.0'
  spec.swift_version = '5.1'
  spec.source_files = 'Source/*.swift'
end
