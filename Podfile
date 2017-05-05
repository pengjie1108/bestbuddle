target 'TonBright' do

pod "AFNetworking" 
pod 'MBProgressHUD', '~> 1.0.0'
pod 'YYModel'
pod 'SSKeychain'

post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
    end
  end
end
end