Pod::Spec.new do |s|

s.name         = "XTlib"
s.version      = "1.7.6"
s.summary      = "a rapid develop lib for iOS"
s.description  = "XTlib. a rapid develop lib for iOS ."
s.homepage     = "https://github.com/Akateason/XTlib"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "teason" => "akateason@qq.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/Akateason/XTlib.git", :tag => s.version }


s.default_subspec = 'base'

    s.subspec 'base' do |base|
        base.source_files = "XTlib/XTlib"
        base.public_header_files = "XTlib/XTlib/*.h"
        
        base.dependency "XTBase"
        base.dependency "XTFMDB",">2.0.0"
        base.dependency "XTReq",">1.3.0"
        base.dependency "XTColor"
        
        base.dependency "FDFullscreenPopGesture"
        base.dependency "IQKeyboardManager"
        base.dependency "BlocksKit"
        
    end

    s.subspec 'Animations' do |a|
    a.source_files = "XTlib/XTlib/Components/Animations"
    a.public_header_files="XTlib/XTlib/Components/Animations/*.h"
    a.dependency "XTlib/base"
    end

    s.subspec 'CustomUIs' do |c|
    c.source_files = "XTlib/XTlib/Components/CustomUIs","XTlib/XTlib/Components/CustomUIs/**/*.{h,m}"
    c.public_header_files="XTlib/XTlib/Components/CustomUIs/*.h","XTlib/XTlib/Components/CustomUIs/**/*.h"
    c.resources = "XTlib/XTlib/Components/CustomUIs/**/*.png","XTlib/XTlib/Components/CustomUIs/**/**/*.png","XTlib/XTlib/Components/CustomUIs/**/*.xib"
    
    c.dependency "XTlib/base"
    c.dependency "RSKImageCropper"
    c.dependency "CHTCollectionViewWaterfallLayout"
    end

end
