//
//  UploadFile.swift
//  MiaoCai
//
//  Created by 王 on 2016/12/13.
//  Copyright © 2016年 iMac. All rights reserved.
//

import Foundation
public class AMUploadFile: NSObject {
    var data:Data = Data()
    var mimeType:String = ""
    var name:String = ""
    public init(withjpg data:Data,name:String){
        self.data = data
        self.name = name
        self.mimeType = "image/jpeg"
    }
}
