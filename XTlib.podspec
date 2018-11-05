
Pod::Spec.new do |s|

  s.name         = "XTlib"
  s.version      = "1.5.14"
  s.summary      = "a rapid develop lib for iOS"
  s.description  = "XTlib. a rapid develop lib for iOS ."
  s.homepage     = "https://github.com/Akateason/XTlib"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "teason" => "akateason@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Akateason/XTlib.git", :tag => s.version }

  #  s.dependency "XTFMDB",">2.0.0"
  #  s.dependency "XTReq",">1.3.0"
  #  #  s.dependency "XTStat"
  #  s.dependency "XTColor"
  #  s.dependency "ReactiveObjC"
  #  s.dependency "Masonry"
  #  s.dependency "SDWebImage"
  #  s.dependency "SSZipArchive"
  #  s.dependency "MJRefresh"
  #  s.dependency "Valet", "2.4.2"
  #  s.dependency "RxWebViewController"
  #  s.dependency "CYLTableViewPlaceHolder"
  #  s.dependency "FTPopOverMenu"

# s.source_files  = "XTlib/XTlib","XTlib/XTlib/**/*.{h,m}","XTlib/XTlib/**/**/*.{h,m}"
# s.public_header_files = "XTlib/XTlib/*.h","XTlib/XTlib/header/*.h","XTlib/XTlib/**/**/*.h"


s.default_subspec = 'base'

# s.subspec 'util' do |util|
# util.source_files = "XTlib/XTlib","XTlib/XTlib/Base","XTlib/XTlib/Base/**/*.{h,m}","XTlib/XTlib/# Base/**/**/*.{h,m}"
# util.public_header_files = "XTlib/XTlib/*.h","XTlib/XTlib/Base/*.h","XTlib/XTlib/Base/# header/*.h","XTlib/XTlib/Base/**/**/*.h"
# util.dependency "XTColor"
# util.dependency "ReactiveObjC"
# util.dependency "Masonry"
# util.dependency "SDWebImage"
# util.dependency "SSZipArchive"
# util.dependency "MJRefresh"
# util.dependency "Valet", "2.4.2"
# util.dependency "RxWebViewController"
# util.dependency "CYLTableViewPlaceHolder"
# util.dependency "FTPopOverMenu"
# util.dependency "YYModel"
# util.dependency "SVProgressHUD"
# end

s.subspec 'base' do |base|
    base.source_files = "XTlib/XTlib","XTlib/XTlib/Base","XTlib/XTlib/Base/**/*.{h,m}","XTlib/XTlib/Base/**/**/*.{h,m}"
    base.public_header_files = "XTlib/XTlib/*.h","XTlib/XTlib/Base/*.h","XTlib/XTlib/Base/header/*.h","XTlib/XTlib/Base/**/**/*.h"
    base.dependency "XTFMDB",">2.0.0"
    base.dependency "XTReq",">1.3.0"
    base.dependency "XTColor"
    base.dependency "ReactiveObjC"
    base.dependency "Masonry"
    base.dependency "SDWebImage"
    base.dependency "SSZipArchive"
    base.dependency "MJRefresh"
    base.dependency "Valet", "2.4.2"
    base.dependency "RxWebViewController"
    base.dependency "CYLTableViewPlaceHolder"
    base.dependency "FTPopOverMenu"
    base.dependency "YYModel"
    base.dependency "SVProgressHUD"
end


s.subspec 'Animations' do |a|
a.source_files = "XTlib/XTlib/Components/Animations"
a.public_header_files="XTlib/XTlib/Components/Animations/*.h"
a.dependency "XTlib/base"
end

s.subspec 'CustomUIs' do |c|
c.source_files = "XTlib/XTlib/Components/CustomUIs","XTlib/XTlib/Components/CustomUIs/**/*.{h,m}"
c.public_header_files="XTlib/XTlib/Components/CustomUIs/*.h","XTlib/XTlib/Components/CustomUIs/**/*.h"
c.resources = "XTlib/XTlib/Components/CustomUIs/**/*.png"
c.dependency "XTlib/base"
end



end
