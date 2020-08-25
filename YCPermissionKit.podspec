#
# Be sure to run `pod lib lint YCPermissionKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YCPermissionKit'
  s.version          = '0.1.1'
  s.summary          = '系统权限的封装'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
基于系统各种请求权限的封装，方便判断系统权限是否可用，以及请求授权
                       DESC

  s.homepage         = 'https://github.com/Loveying/YCPermissionKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Loveying' => 'xyy_ios@163.com' }
  s.source           = { :git => 'https://github.com/Loveying/YCPermissionKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.source_files = 'YCPermissionKit/Classes/**/*.swift'
  s.requires_arc = true
  s.frameworks = 'UIKit', 'Foundation'
  # s.resource_bundles = {
  #   'YCPermissionKit' => ['YCPermissionKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
