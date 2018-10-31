Pod::Spec.new do |s|
  s.name             = 'XTlib'
  s.version          = '0.1.0'
  s.summary          = 'A short description of XTlib.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/ripperhe/XTlib'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ripper' => 'ripperhe@qq.com' }
  s.source           = { :git => 'https://github.com/ripperhe/XTlib.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'XTlib/Classes/**/*'

  # s.resource_bundles = {
  #   'XTlib' => ['XTlib/Assets/*.png']
  # }

  #s.subspec 'XTlib' do | sm |
      #sm.source_files = 'XTlib/ZYSubModule/**/*'
      #sm.dependency 'AFNetworking', '~> 2.3'
  #end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
