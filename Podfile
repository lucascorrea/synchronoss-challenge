platform :ios, '9.0'

target 'synchronoss' do

  inhibit_all_warnings!

  pod 'Alamofire'
  pod 'SwiftLint'
  pod 'SWXMLHash', '~> 4.0.0'
  pod 'SCTwitter'
  pod 'Fabric'
  pod 'Crashlytics'
  
  target 'SynchronossTests' do
    use_frameworks!
    inherit! :search_paths
    
    pod 'Quick'
    pod 'Nimble'    
  end

end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
        end
    end
end
