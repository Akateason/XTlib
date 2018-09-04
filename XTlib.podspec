
Pod::Spec.new do |s|

  s.name         = "XTlib"
  s.version      = "1.2.24"
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


s.default_subspec = 'base'

s.subspec 'util' do |util|
util.source_files = "XTlib/XTlib","XTlib/XTlib/Base","XTlib/XTlib/Base/**/*.{h,m}","XTlib/XTlib/Base/**/**/*.{h,m}"
util.public_header_files = "XTlib/XTlib/*.h","XTlib/XTlib/Base/*.h","XTlib/XTlib/Base/header/*.h","XTlib/XTlib/Base/**/**/*.h"
end

s.subspec 'base' do |base|
base.source_files = "XTlib/XTlib","XTlib/XTlib/Base","XTlib/XTlib/Base/**/*.{h,m}","XTlib/XTlib/Base/**/**/*.{h,m}"
base.public_header_files = "XTlib/XTlib/*.h","XTlib/XTlib/Base/*.h","XTlib/XTlib/Base/header/*.h","XTlib/XTlib/Base/**/**/*.h"
# base.dependency "XTStat"
end

s.subspec 'Animations' do |a|
a.source_files = "XTlib/XTlib/Components/Animations","XTlib/XTlib/Base/header","XTlib/XTlib/Base/Utils/UIkit/Adapt"
a.public_header_files="XTlib/XTlib/Components/Animations/*.h","XTlib/XTlib/Base/header/*.h","XTlib/XTlib/Base/Utils/UIkit/Adapt/*.h"
end

s.subspec 'CustomUIs' do |c|
c.source_files = "XTlib/XTlib/Components/CustomUIs","XTlib/XTlib/Base/header","XTlib/XTlib/Base/Utils/UIkit/Adapt"
c.public_header_files="XTlib/XTlib/Components/CustomUIs/*.h","XTlib/XTlib/Base/header/*.h","XTlib/XTlib/Base/Utils/UIkit/Adapt/*.h"
end



end
