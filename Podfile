# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SharonBhandhan' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for CenturyPly_JSON
  pod 'SDWebImage'
  pod 'lottie-ios'
  pod 'LanguageManager-iOS'
  pod 'IQKeyboardManagerSwift'
  pod 'SlideMenuControllerSwift'
  pod 'Alamofire', '~> 4.0'
  pod "ImageSlideshow/Alamofire"
  pod 'Toast-Swift', '~> 5.0.1'
  pod 'GoogleAnalytics'
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
  pod 'Firebase/Analytics'
  pod 'Crashlytics', '~> 3.14.0'
  pod 'KSImageCarousel'
  pod 'ReachabilitySwift'
  pod 'DPOTPView'




end
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
           if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 11.0
             config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
           end
        end
    end
 end
