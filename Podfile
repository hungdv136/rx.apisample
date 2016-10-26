use_frameworks!

target 'FRP.ApiSample' do
    pod 'RxSwift',    '3.0.0-beta.2'
    pod 'RxCocoa',    '3.0.0-beta.2'
    pod 'Alamofire', '~> 4.0'
    pod 'PureLayout'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end
