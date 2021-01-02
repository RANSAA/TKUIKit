file_header       = "*.h"
file_source       = "*.{h,m}"


name		= "TKUIKit"
ver 		= "0.0.1"
homepage 	= "https://github.com/RANSAA/TKUIKit"



Pod::Spec.new do |s|

s.name         = "#{name}"   
s.summary      = '该项目集成了一些常用的UI控件'
s.homepage     = "#{homepage}"
s.source       = { :git => "#{homepage}.git", :tag => "v#{s.version}" } #对应github资源与版本
s.license      = "MIT"     #开源协议方式
s.author       = { "sayaDev" => "1352892108@qq.com" }    #作者
s.requires_arc = true    #支持arc
s.platform     = :ios, '9.0'
#s.swift_version = '5.0'


#第一个配置：处理Include of non-modular header inside framework module ：处理静态库在工程项目中，找不到三方库的问题
s.xcconfig = { "CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES" => "YES"}#l



s.frameworks = 'UIKit', 'Foundation'

s.public_header_files  = "#{name}/#{file_header}"

s.source_files  =  "#{name}/#{file_source}"

s.dependency 'TKBaseKit/TKSDKUniversal'





#s.default_subspec = 'Public'

# spec.subspec 'Public' do |ss|
#     ss.source_files         = public_source
#     ss.public_header_files  = public_header
#     ss.ios.frameworks       = "Foundation", "UIKit"
#     # ss.dependency "#{name}/Resources"    #依赖
#   end

#  spec.subspec 'Photo' do |ss|
#     ss.source_files         = "#{name}/Photo/#{file_source}"
#     ss.public_header_files  = "#{name}/Photo/#{file_header}"
#     ss.ios.frameworks       = "Photos"
#     ss.dependency "#{public_base}"    #依赖
#  end


end
