Pod::Spec.new do |s|

s.name         = "LinkimFoundation"
s.version      = "0.0.1"
s.license      = "MIT"
s.summary      = "上海凌晋信息技术有限公司开发的基于Swift的基础库"

s.homepage     = "https://github.com/liuweicode/LinkimFoundation"
s.social_media_url = "http://www.linkim.com.cn"
s.author       = { "liuwei" => "i@liuwei.co" }

s.platform     = :ios
s.ios.deployment_target = "8.0"

s.source       = { :git => "https://github.com/liuweicode/LinkimFoundation.git", :tag => "#{s.version}" }
s.source_files = 'LinkimFoundation/Classes/**/*'

s.frameworks  = "UIKit", "Foundation"

s.prefix_header_contents = '#import <UIKit/UIKit.h>', '#import <Foundation/Foundation.h>'

s.requires_arc = true

s.dependency 'SnapKit', '~> 0.21.0'

end