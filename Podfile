# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'Superkart' do
  use_frameworks!
  pod 'FacebookCore','~>0.2.0'
  pod 'FacebookLogin','~>0.2.0'
  pod 'Alamofire','~>4.0'
  pod 'RealmSwift'
  pod 'VCMaterialDesignIcons'
  pod 'BarcodeScanner'
  pod 'FontAwesomeKit'
  pod 'HexColors'
  pod 'ECSlidingViewController', '~> 2.0.3'

end
target 'SuperkartTests' do
end
target 'SuperkartUITests' do
end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'

    end
  end
end
