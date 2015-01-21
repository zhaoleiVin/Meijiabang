//
//  ZXY_NetHelperOperate.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/20.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

let _ZXY_NetInstance = ZXY_NetHelperOperate()
class ZXY_NetHelperOperate: NSObject {
    class var sharedInstance:ZXY_NetHelperOperate
    {
        return _ZXY_NetInstance
    }

    /**
    判断网络连接状态
    
    :param: statusBlock 当连接状态改变的时候将 状态码传递
    */
    func judgeNetCanConnect(currentStatus statusBlock: ((status :AFNetworkReachabilityStatus)->Void)?) -> Void
    {
        var net : AFNetworkReachabilityManager = AFNetworkReachabilityManager.sharedManager()
        net.startMonitoring()
        net.setReachabilityStatusChangeBlock(statusBlock)
    }
    
    
    /**
    网络请求连接
    
    :param: urlString 数据连接请求API
    :param: parameter 数据请求参数
    :param: success   数据连接成功的时候的回调函数
    :param: errors    数据连接失败的时候的回调函数
    */
    func startGetDataPost(urlString: String , parameter: Dictionary<String ,AnyObject>? , successBlock success:((returnDic : Dictionary<String ,AnyObject>)->Void)? , failBlock errors:((error: NSError) -> Void)?)
    {
        var afnet = AFHTTPRequestOperationManager()
        var stampTime = timeStamp()
    
        
        afnet.responseSerializer = AFJSONResponseSerializer()
        afnet.responseSerializer.acceptableContentTypes = NSSet(object: "text/html")
        if(parameter != nil)
        {
            var sendParameter = parameter
            sendParameter!["timestamp"] = stampTime
            sendParameter!["token"]     = timeStampMD5("meijia"+stampTime)
            afnet.POST(urlString, parameters: sendParameter, success: { (operation:AFHTTPRequestOperation!, anyObject: AnyObject!) -> Void in
                    if(success != nil)
                    {
                        println(operation.responseString)
                        var returnData = operation.responseData
                        var json: AnyObject?       = NSJSONSerialization.JSONObjectWithData(returnData, options: NSJSONReadingOptions.MutableLeaves, error: nil)
                        var jsonDic : Dictionary<String , AnyObject> = json as Dictionary<String, AnyObject>
                        success!(returnDic: jsonDic)
                    }
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    if(errors != nil)
                    {
                        errors!(error:error)
                    }
            })
        }
        else
        {
            afnet.GET(urlString, parameters: "", success: { (operation: AFHTTPRequestOperation!, anyObject: AnyObject!) -> Void in
                
                if(success != nil)
                {
                    var returnData = operation.responseData
                    var json: AnyObject?       = NSJSONSerialization.JSONObjectWithData(returnData, options: NSJSONReadingOptions.MutableLeaves, error: nil)
                    var jsonDic : Dictionary<String , AnyObject> = json as Dictionary<String, AnyObject>
                    success!(returnDic: jsonDic)
                }

                
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    
                    if(errors != nil)
                    {
                        errors!(error:error)
                    }
                    
            })
            
        
        }
    }
    
    /**
    获取时间戳
    
    :returns: 返回时间戳
    */
    func timeStamp() -> String
    {
        let a = Int(NSDate().timeIntervalSince1970)
        return "\(a)"
    }
    
    /**
    将时间戳加密
    
    :param: addString 需要加密的字符串
    
    :returns: 返回加密后的时间戳
    */
    func timeStampMD5(addString : NSString) -> String
    {
        return addString.md5()
    }

}