# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'IMKB' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for IMKB
pod 'Alamofire', '~> 4.7'
pod 'SWXMLHash', '~> 4.0.0'
pod 'AEXML'
pod 'StringExtensionHTML'
pod 'Charts'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
    end
  end
end