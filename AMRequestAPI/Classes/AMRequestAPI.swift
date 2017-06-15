//
//  RequestAPI.swift
//  MiaoCai
//
//  Created by imac on 2016/10/24.
//  Copyright © 2016年 iMac. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import SwiftyJSON





public class AMRequestAPI: NSObject {
    
    public static let share = AMRequestAPI()
    private override init() {}
    //默认参数
    let defaultParams:[String:Any] = [:]

    
    func addDefaultParams(params: [String:Any]?) -> Dictionary<String,Any>?{
        
        var tempParams:[String:Any] = params ?? [:]
        
        for (k, v) in defaultParams {
            tempParams.updateValue(v, forKey: k)
        }
        return tempParams

    }

    //promise的请求
    
    //url: 请求地址
    //body: 请求参数
    //errorHandle: 是否自动处理错误
    public func post(url:String,body:Dictionary<String, Any>?)->Promise<JSON>{
        
        let params = addDefaultParams(params: body)
        let purl = url
        var tempRes:JSON?
        NSLog("请求地址%@", purl)
        NSLog("请求参数%@", params!.description)
        //2种类型判断，带文件传输用upload
        var hasData = false
        
        var p:Promise<JSON>?
        var nextp:Promise<JSON>?
        if(body != nil){
            for item in body!.enumerated(){
                if(item.element.value is AMUploadFile){
                    hasData = true
                }
            }
            if(hasData){
                NSLog("含文件上传")
                p = self.upload(url: purl, data: params!)
            }
        }
        
        if(!hasData){
            p = Alamofire.request(purl, method: HTTPMethod.post, parameters: params).responseJSON().then(execute: { (response) -> JSON in
                tempRes = JSON(response);
                
                return tempRes!
            })
        }
        if(p != nil){
            nextp = p?.then(execute: { (json) -> JSON in
                return json
            })
        }
        
        return nextp!
    }
    //上传文件promise封装
    func upload(url:String,data:[String:Any])->Promise<JSON>{

        
        return Promise{ fulfill, reject in
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                for item in data.enumerated(){
                    
                    if item.element.value is String {
                        //字符串类型
                        let str = item.element.value as! String
                       
                        multipartFormData.append(str.data(using: String.Encoding.utf8)!, withName: item.element.key)
                    }else if(item.element.value is AMUploadFile){
                        //文件类型
                        let file = item.element.value as! AMUploadFile
                        multipartFormData.append(file.data, withName: item.element.key, fileName: "a", mimeType: file.mimeType)
                        
                    }
                }
                
            }, to: url, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    _ = upload.responseJSON().then(execute: { (res) -> Void in
                        let temp = JSON(res)
                        print(temp)
                        fulfill(temp)
                    })
                    
                case .failure(let encodingError):
                    print(encodingError)
                }
            })

            
            
        }
    
        
    }
    
}
