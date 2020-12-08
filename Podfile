# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

# ignore all warnings from all pods
inhibit_all_warnings!

target 'Reportedly' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Reportedly
  pod 'Alamofire', '~> 5.2'
  pod 'Apollo'
  pod 'NimbleExtension', :git => 'https://github.com/nimblehq/NimbleExtension.git'
  pod 'R.swift'
  pod 'ReachabilitySwift'
  pod 'SnapKit'
  pod 'SwiftLint'
  pod 'SwifterSwift'
  
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
      end
    end
end
