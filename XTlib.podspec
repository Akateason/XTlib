
Pod::Spec.new do |s|

  s.name         = "XTlib"
  s.version      = "1.2.15"
  s.summary      = "a rapid develop lib for iOS"
  s.description  = "XTlib. a rapid develop lib for iOS ."
  s.homepage     = "https://github.com/Akateason/XTlib"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "teason" => "akateason@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Akateason/XTlib.git", :tag => s.version }

  s.dependency "XTFMDB"
  s.dependency "XTReq"
  s.dependency "XTColor"
  s.dependency "ReactiveObjC"
  s.dependency "Masonry"
  s.dependency "SDWebImage"
  s.dependency "SSZipArchive"
  s.dependency "MJRefresh"
  s.dependency "Valet", "2.4.2"
  s.dependency "RxWebViewController"

# s.source_files  = "XTlib/XTlib","XTlib/XTlib/**/*.{h,m}","XTlib/XTlib/**/**/*.{h,m}"
# s.public_header_files = "XTlib/XTlib/*.h","XTlib/XTlib/header/*.h","XTlib/XTlib/**/**/*.h"


# 默认的使用模块
s.default_subspec = 'FSLib'
# 个个子模块的个自的源码路径
s.subspec 'FSLib' do |fsLib|
fsLib.source_files = "XTlib/XTlib","XTlib/XTlib/**/*.{h,m}","XTlib/XTlib/**/**/*.{h,m}"
fsLib.public_header_files = "XTlib/XTlib/*.h","XTlib/XTlib/header/*.h","XTlib/XTlib/**/**/*.h"
end




end
