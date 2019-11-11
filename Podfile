platform :ios, '8.0'

use_frameworks!



target 'XTlib' do
    
    pod 'XTBase',:path => '../XTBase/'
    pod 'XTFMDB', :path => '../XTFMDB/'
    pod 'XTReq', :path => '../XTReq/'
    pod 'XTColor',:path => '../XTColor/'
    pod 'XTTable'

#    pod 'XTBase'
#    pod 'XTFMDB'
#    pod 'XTReq'
#    pod 'XTColor'

    pod 'JKCategories'
    pod 'LxDBAnything'
    pod 'FDFullscreenPopGesture'
    #pod 'iCarousel'
    #pod 'BlocksKit'
    #pod 'Bugly'
    pod 'RSKImageCropper','2.2.1'
    pod 'CHTCollectionViewWaterfallLayout'
end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.new_shell_script_build_phase.shell_script = "mkdir -p $PODS_CONFIGURATION_BUILD_DIR/#{target.name}"
        target.build_configurations.each do |config|
            config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
            config.build_settings.delete('CODE_SIGNING_ALLOWED')
            config.build_settings.delete('CODE_SIGNING_REQUIRED')
        end
    end
end
