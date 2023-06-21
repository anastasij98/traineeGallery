# Uncomment the next line to define a global platform for your project

target 'TraineeGAllery' do
  inherit! :search_paths
  platform :ios, '13.0'

  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'SnapKit', '~> 5.6.0'
  pod 'Alamofire'
  pod 'Kingfisher', '~> 7.0'

  pod 'RxSwift'
  pod 'RxAlamofire'

  pod 'R.swift', '6.1.0'

  pod 'RxNetworkApiClient', :git => 'git@github.com:Cheeezcake/RxNetworkApiClient.git'

  pod "DBDebugToolkit"

  pod "TTGSnackbar"

  pod 'PKHUD', '~> 5.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end