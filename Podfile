platform :ios, '10.0'

def pods
  # Clean Architecture
  pod 'MGArchitecture', '0.4.0'
  pod 'MGAPIService', '0.6.0'
  pod 'MGLoadMore', '0.3.0'
  
  # Core
  pod 'ObjectMapper', '3.3'
  pod 'Reusable', '4.0.4'
  pod 'Then', '2.4'
  pod 'MJRefresh', '3.1'
  pod 'Validator', '3.0.2'
  
  # Rx
  pod 'NSObject+Rx', '4.4'
  pod 'RxDataSources', '3.1'
  
  #
  pod 'MBProgressHUD', '1.1'
  pod 'SDWebImage', '5.0'
  pod 'ActionSheetPicker-3.0', '2.3'
  pod 'Localize-Swift', '2.0'
  pod 'SlideMenuControllerSwift', '4.0.0'
  pod 'RxViewController', '0.4'
  pod 'IQKeyboardManagerSwift'
  pod 'Parchment', '1.6'
  pod 'lottie-ios'
  pod 'SnapKit', '4.0.1'
  pod 'TagListView', '1.4'
  pod 'Hero'
  pod 'Nuke', '7.6'
  pod 'SwiftLint'
  
  # Firebase Push
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
end

def test_pods
  pod 'RxBlocking', '4.5'
end

target 'MovieDB' do
  use_frameworks!
  inhibit_all_warnings!
  pods
  
  target 'MovieDBTests' do
    inherit! :search_paths
    test_pods
  end
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['Validator', 'RxDataSources', 'SlideMenuControllerSwift'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.0'
      end
    end
  end
end
