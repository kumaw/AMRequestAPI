//
//  ViewController.swift
//  AMRequestAPI
//
//  Created by kumaw on 06/15/2017.
//  Copyright (c) 2017 kumaw. All rights reserved.
//

import UIKit
import AMRequestAPI
import Alamofire
class ViewController: UIViewController {
    @IBOutlet weak var url: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func postTest(_ sender: Any) {
        let url = self.url.text
        //var a =
        
        _ = AMRequestAPI.share.post(url: url ?? "", body: ["vale":"test"]).then { (res) -> Void in
            print(res)
        }
        
        
    
    }

  
    @IBAction func postUp(_ sender: Any) {
        let url = self.url.text
        let imgup = AMUploadFile(withjpg: Data(), name: "image")
        
        let obj:[String : Any] = [
            "vale":"test",
            "image":imgup
        ]
        
        _ = AMRequestAPI.share.post(url: url ?? "", body: obj).then(execute: { (res) -> Void in
            print(res)
        })
        
    }
    
    
}

