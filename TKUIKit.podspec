file_header       = "*.h"
file_source       = "*.{h,m,xib}"


name		= "TKUIKit"
version 	= "0.0.1"
homepage 	= "https://github.com/RANSAA/TKUIKit"



Pod::Spec.new do |s|

s.name         = "#{name}"   
s.summary      = '该项目集成了一些常用的UI控件'
s.homepage     = "#{homepage}"
s.version	     = "#{version}"
s.source       = { :git => "#{homepage}.git", :tag => "v#{s.version}" } #对应github资源与版本
s.license      = "MIT"     #开源协议方式
s.author       = { "sayaDev" => "1352892108@qq.com" }    #作者
s.requires_arc = true    #支持arc
s.platform     = :ios, '9.0'  #单一平台
s.static_framework = true  #静态库---该pod中依赖了静态库，需要将该属性设置为true



# s.pod_target_xcconfig = { 'PRODUCT_BUNDLE_IDENTIFIER': 'com.sayaDev.TKUIKit'}
s.info_plist = {
  'TEST-INFO-PLIST' => 'com.sayaDev.TKUIKit',
}
# s.user_target_xcconfig = { 'ABC' => 'YES' }



# s.ios.deployment_target = '9.0'
# s.osx.deployment_target = '10.13'
#s.swift_version = '5.0'


# s.frameworks = 'UIKit', 'Foundation', 'CoreServices'
s.source_files         =  "#{name}/#{file_source}"
s.public_header_files  = "#{name}/#{file_header}"



# s.resource_bundles = {
#   'TKUIKit' => ["#{name}/**/**/*.{xib}"]#pod 编译后会生成TKUIKit.bundle 文件
# }


s.subspec 'Core' do |ss|
  ss.source_files         = "#{name}/Core/#{file_source}" , "#{name}/Core/**/#{file_source}"
  ss.public_header_files  = "#{name}/Core/#{file_header}" , "#{name}/Core/**/#{file_header}"
  # ss.resources            = "#{name}/Core/*.bundle" ##将项目中的bundle文件导入pod的Resources文件夹中
  ss.resource_bundles = {
    'TKUIKit' => ["#{name}/**/**/*.{xib}"]#pod 编译后会生成TKUIKit.bundle 文件
  }
  ss.dependency 'TKBaseKit/TKSDKUniversal'
  ss.dependency 'TKPermissionKit/Photo'
  ss.dependency 'TKPermissionKit/Camera'
  ss.dependency 'MBProgressHUD'
end

s.subspec 'Anim' do |ss|
  ss.source_files         = "#{name}/Anim/#{file_source}" , "#{name}/Anim/**/#{file_source}"
  ss.public_header_files  = "#{name}/Anim/#{file_header}" , "#{name}/Anim/**/#{file_header}"
  ss.dependency "TKUIKit/Core"    #依赖
end

s.subspec 'View' do |ss|
  ss.source_files         = "#{name}/View/#{file_source}","#{name}/View/**/#{file_source}"
  ss.public_header_files  = "#{name}/View/#{file_header}","#{name}/View/**/#{file_header}"
  ss.dependency "TKUIKit/Core"    #依赖
  ss.dependency "TKUIKit/Anim"    #依赖
end

s.subspec 'Tool' do |ss|
  ss.source_files         = "#{name}/Tool/#{file_source}","#{name}/Tool/**/#{file_source}"
  ss.public_header_files  = "#{name}/Tool/#{file_header}","#{name}/Tool/**/#{file_header}"
  ss.dependency "TKUIKit/Core"    #依赖
end




end
