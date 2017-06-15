# AMRequestAPI

[![CI Status](http://img.shields.io/travis/kumaw/AMRequestAPI.svg?style=flat)](https://travis-ci.org/kumaw/AMRequestAPI)
[![Version](https://img.shields.io/cocoapods/v/AMRequestAPI.svg?style=flat)](http://cocoapods.org/pods/AMRequestAPI)
[![License](https://img.shields.io/cocoapods/l/AMRequestAPI.svg?style=flat)](http://cocoapods.org/pods/AMRequestAPI)
[![Platform](https://img.shields.io/cocoapods/p/AMRequestAPI.svg?style=flat)](http://cocoapods.org/pods/AMRequestAPI)

## 简介
基于 Alamofire、PromiseKit、SwiftyJSON 封装的基本post请求、上传库


## 安装

```ruby
pod "AMRequestAPI",:git => 'https://github.com/kumaw/AMRequestAPI.git'
```
## 使用
###AMRequestAPI对象
####post方法，返回一个Promise<JSON>对象
url: String请求地址  
body: Dictionary 请求参数 ,value可包含AMUploadFile对象

```swift
AMRequestAPI.share.post(url:String,body:Dictionary<String, Any>?)->Promise<JSON>
```
####defaultParams属性
每次请求默认的参数

```swift
AMRequestAPI.share.defaultParams = [:]
```

###AMUploadFile对象

withjpg:image的data  
name:参数名

```swift
AMUploadFile(withjpg: Data, name: String)
```
###AMError对象
catch捕获的错误，自定义错误时需要继承AMError


## Author

kumaw, atmwjf@hotmail.com

## License

AMRequestAPI is available under the MIT license. See the LICENSE file for more info.
