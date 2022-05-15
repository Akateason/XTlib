Pod::Spec.new do |s|

s.name         = "XTlib"
s.version      = "2.0.7.2"
s.summary      = "a rapid develop lib for iOS"
s.description  = "XTlib. a rapid develop lib for iOS ."
s.homepage     = "https://github.com/Akateason/XTlib"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "teason" => "akateason@qq.com" }
# s.platform     = :ios, "9.0"
s.source       = { :git => "https://gitee.com/mamba24xtc/xtlib.git", :tag => s.version }


s.default_subspec = 'base'

    s.subspec 'base' do |base|
        base.source_files = "XTlib/XTlib"
        base.public_header_files = "XTlib/XTlib/*.h"
        
        base.dependency "XTBase"
        base.dependency "XTFMDB"
        base.dependency "XTReq"
        base.dependency "XTColor"
        base.dependency "XTTable"
        base.dependency "XTRouter"
        base.dependency "XTIAP"
        
        base.dependency "FDFullscreenPopGesture"
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
