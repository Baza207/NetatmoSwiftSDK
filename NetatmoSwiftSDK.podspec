Pod::Spec.new do |s|

  s.name         = "NetatmoSwiftSDK"
  s.version      = "0.0.1"
  s.summary      = "NetatmoSwiftSDK is a Swift wrapper around the Netatmo API."
  s.homepage     = "https://github.com/Baza207/NetatmoSwiftSDK"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "James Barrow" => "james@pigonahill.com" }
  s.platform     = :ios
  s.ios.deployment_target = "12.0"
  s.source       = { :git => "https://github.com/Baza207/NetatmoSwiftSDK.git", :tag => "#{s.version}" }
  s.source_files = "Source/**/*.swift"
  s.exclude_files = 'Tests/**/TestConfig.{json}'
  s.swift_version = "5.1"
  s.frameworks = "UIKit", "CoreLocation", "SafariServices"

end
