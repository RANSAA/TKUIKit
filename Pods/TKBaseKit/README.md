### TKBaseKit

#### 简介：
TKBaseKit是的常用的基础框架封装，其中包括两个框架，分别是：
> TKSDKUniversal: 为基础框架，包含自定义导航，自定义NavBar,以及一些常用的工具类。

> TKSDKTool：主要是对一些三方框架的二次封装，如F网络请求，刷新，加密等。

#### 使用：
1. CocoaPods方式
```
//全部引入
pod 'TKBaseKit', '~> 2.0'
//模块引入
pod 'TKBaseKit/TKSDKUniversal'
pod 'TKBaseKit/TKSDKTool'
```

2. 手动添加
```
第一步：先将如下文件添加到项目中：
    TKSDKUniversal.framework
    TKSDKTool.framework
    TKSDKTool.bundle
第二步：导入三方依赖(匹配指定版本)
      pod 'Masonry'
      pod 'YYModel'
      pod 'MBProgressHUD'
      pod 'GTMBase64'        , '~> 1.0.1'             
      pod 'MJRefresh'        , '~> 3.5.0'
      pod 'AFNetworking'     , '~> 4.0'

     **注意：三方依赖库也会持续的更新**
     
第三步：
    1.设置"Other Linker Flags"-->添加: -ObjC 
    2.将Build Settings中的Allow Non-modular Includes In Framework Modules设为YES
```

#### 注意：
1.如果使用TKSDKTableViewController，TKSDKCollectionViewController出现导航条被遮挡的情况，请进行刷新，使用:
```
[self makeNavigationBarOnTop]; 
```
2.其它操作请查看文件注释。\
3.iphoneos_maccatalyst中的可以用于iPhone与Mac模式运行
