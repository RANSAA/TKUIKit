file_header       = "*.h"
file_source       = "*.{h,m,xib}"


name		= "TKUIKit"
version 	= "0.0.1"
homepage 	= "https://github.com/RANSAA/TKUIKit"



Pod::Spec.new do |s|

s.name         = "#{name}"   
s.summary      = '该项目集成了一些常用的UI控件'
s.homepage     = "#{homepage}"
s.version	   = "#{version}"
s.source       = { :git => "#{homepage}.git", :tag => "v#{s.version}" } #对应github资源与版本
s.license      = "MIT"     #开源协议方式
s.author       = { "sayaDev" => "1352892108@qq.com" }    #作者
s.requires_arc = true    #支持arc

s.platform     = :ios, '9.0'  #单一平台

# s.ios.deployment_target = '9.0'
# s.osx.deployment_target = '10.13'


#s.swift_version = '5.0'


#第一个配置：处理Include of non-modular header inside framework module ：处理静态库在工程项目中，找不到三方库的问题
# s.xcconfig = { "CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES" => "YES"}#l
s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}



s.frameworks = 'UIKit', 'Foundation', 'CoreServices'

s.public_header_files  = "#{name}/#{file_header}"

s.source_files  =  "#{name}/#{file_source}"

# s.dependency 'TKBaseKit/TKSDKUniversal'
# s.dependency 'TKBaseKit/TKSDKTool'

s.resource_bundles = {
  'TKUIKit' => ["#{name}/**/**/*.{xib}"]#pod 编译后会生成TKUIKitBundle.bundle 文件
}


s.subspec 'Core' do |ss|
  ss.source_files         = "#{name}/Core/#{file_source}" , "#{name}/Core/**/#{file_source}"
  ss.public_header_files  = "#{name}/Core/#{file_header}" , "#{name}/Core/**/#{file_header}"
  # ss.resources            = "#{name}/Core/*.bundle"
  # ss.dependency 'TKBaseKit/TKSDKTool'
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
  # ss.resource_bundles = {
  #   'TKUIKit' => ["#{name}/View/**/*.{xib}"]#pod 编译后会生成TKUIKitBundle.bundle 文件
  # }
end

s.subspec 'Tool' do |ss|
  ss.source_files         = "#{name}/Tool/#{file_source}","#{name}/Tool/**/#{file_source}"
  ss.public_header_files  = "#{name}/Tool/#{file_header}","#{name}/Tool/**/#{file_header}"
  ss.dependency "TKUIKit/Core"    #依赖
end


end
