
name = "TKUIKit"

file_header       = "*.h"
file_source       = "*.{h,m}"


Pod::Spec.new do |s|

s.name         = "#{name}"   #框架名称
s.version      = '0.0.1'
s.summary      = '该项目集成了一些常用的UI控件'
s.homepage     = 'https://github.com/RANSAA/TKUIKit'
s.source       = { :git => "https://github.com/RANSAA/TKUIKit.git", :tag => "v#{s.version}" } #对应github资源与版本
s.license      = "MIT"     #开源协议方式
s.author       = { "sayaDev" => "1352892108@qq.com" }    #作者
s.platform     = :ios, '9.0'
s.requires_arc = true    #支持arc


#s.swift_version = '5.0'
#s.default_subspec = 'Core'

s.frameworks = 'UIKit', 'Foundation'


s.public_header_files  = "#{name}/#{file_header}"
s.source_files  =  "#{name}/#{file_source}"

s.dependency 'TKBaseKit/TKSDKUniversal'


end
