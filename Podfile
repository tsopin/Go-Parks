# Uncomment the next line to define a global platform for your project
#platform :ios, '10.3'

target 'Go Parks' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for Go Parks
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'Firebase/Core'
  
  
  
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.2'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.3'
    end
  end
end
