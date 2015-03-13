//
//  ZXY_CourseDetailVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/3/12.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ZXY_CourseDetailVC: UIViewController {

    @IBOutlet weak var currentWebV: UIWebView!
    
    @IBOutlet weak var dianZanBtn: UIButton!
    
    @IBOutlet weak var shouCangBtn: UIButton!
    
    @IBOutlet weak var fenXiangBtn: UIButton!
    
    private var dataID : String!
    
    private var dataForBtns : ZXYCourseUserStatusBase?
    
    private var stringURL : String!
    private var shareURL  : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLoadData()
        // Do any additional setup after loading the view.
        var timeStamp = ZXY_NetHelperOperate().timeStamp()
        var token     = ZXY_NetHelperOperate().timeStampMD5("meijia\(timeStamp)")
        stringURL = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_MainCourseAPI(ZXY_MainCourseAPIType.CourseDetail) + "?course_id=\(dataID)&timestamp=\(timeStamp)&token=\(token)"
        shareURL  = ZXY_ALLApi.ZXY_ShareMainCourseAPI + dataID
        var request = NSURLRequest(URL: NSURL(string: stringURL)!, cachePolicy: NSURLRequestCachePolicy.ReloadRevalidatingCacheData, timeoutInterval: 30)
        self.currentWebV.loadRequest(request)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setInitDataID(dataID : String)
    {
        self.dataID = dataID
    }
    
    func startLoadData()
    {
        var userID = LCYCommon.sharedInstance.userInfo?.userID
        if(userID == nil)
        {
            return
        }
        userID     = userID ?? ""
        var parameter = ["user_id": userID! , "course_id": self.dataID]
        var urlString = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_MainCourseAPI(ZXY_MainCourseAPIType.CourseUserStatus)
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: parameter, successBlock: {[weak self] (returnDic) -> Void in
            self?.dataForBtns = ZXYCourseUserStatusBase(dictionary: returnDic)
            var resultDouble   = self?.dataForBtns?.result
            var resultString   = "\(Int(resultDouble!))"
            if(ZXY_ErrorMessageHandle.resultCodeIsSuccess(resultString))
            {
                self?.startInitBtns()
            }
            else
            {
                var message = ZXY_ErrorMessageHandle.messageForErrorCode(resultString)
                self?.showAlertEasy("提示", messageContent: message)
            }

        }) { [weak self] (error) -> Void in
            self?.showAlertEasy("提示", messageContent: "网络连接错误")
            ""
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func startInitBtns()
    {
        if let status = dataForBtns
        {
            var isStarNum = status.data.isStar
            var isCollectNum = status.data.isCollect
            
            if(isStarNum == "1")
            {
                self.dianZanBtn.selected = true
            }
            else
            {
                self.dianZanBtn.selected = false
            }
            
            if(isCollectNum == "1")
            {
                self.shouCangBtn.selected = true
            }
            else
            {
                self.shouCangBtn.selected = false
            }
            
        }
        else
        {
            return
        }
    }
    
    @IBAction func dianZanAction(sender: AnyObject) {
        self.changeStatus(0)
    }
    
    

    @IBAction func shouCangAction(sender: AnyObject) {
        self.changeStatus(1)
    }
    
    /**
    改变状态码
    
    :param: types 0 代表 点赞 ， 1 代表 收藏
    */
    func changeStatus(types : Int)
    {
        
        var currentURL = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_MainCourseAPI(ZXY_MainCourseAPIType.CourseStart)
        if(types == 1)
        {
            currentURL = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_MainCourseAPI(ZXY_MainCourseAPIType.CourseCollect)
        }
        if let status = dataForBtns
        {
            var isStarNum = status.data.isStar
            var isCollect = status.data.isCollect
            var userID = LCYCommon.sharedInstance.userInfo?.userID
            if(userID == nil)
            {
                return
            }
            
            var statusNum = isStarNum
            if(types == 1)
            {
                statusNum = isCollect
            }
            
            if(statusNum == "1")
            {
                statusNum = "2"
            }
            else
            {
                statusNum = "1"
            }
            
            
            var parameter = ["user_id": userID , "course_id": dataID , "status":statusNum]
            ZXY_NetHelperOperate().startGetDataPost(currentURL, parameter: parameter, successBlock: {[weak self] (returnDic) -> Void in
                var result = returnDic["result"] as Int
                var resultString   = "\(result)"
                if(ZXY_ErrorMessageHandle.resultCodeIsSuccess(resultString))
                {
                    
                    if(types == 1)
                    {
                        self?.dataForBtns!.data.isCollect = statusNum
                    }
                    else
                    {
                        self?.dataForBtns!.data.isStar = statusNum
                    }
                    self?.startInitBtns()
                }
                else
                {
                    var message = ZXY_ErrorMessageHandle.messageForErrorCode(resultString)
                    self?.showAlertEasy("提示", messageContent: message)
                }
                
                
                }, failBlock: {[weak self] (error) -> Void in
                    self?.showAlertEasy("提示", messageContent: "网络连接错误")
                    ""
            })
        }
        else
        {
            return
        }

    }
    
    @IBAction func fenXiangAction(sender: AnyObject) {
        UMSocialWechatHandler.setWXAppId(ZXY_ConstValue.WXAPPKEY.rawValue, appSecret: ZXY_ConstValue.WXAPPSECURITY.rawValue, url: shareURL)
        UMSocialQQHandler.setQQWithAppId(ZXY_ConstValue.QQAPPID.rawValue, appKey: ZXY_ConstValue.QQAPPKEY.rawValue, url: shareURL)
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: ZXY_ConstValue.UMAPPKEY.rawValue, shareText: self.title, shareImage: UIImage(named: "icon4_58"), shareToSnsNames: [UMShareToSina,UMShareToTencent,UMShareToQzone,UMShareToQQ,UMShareToWechatSession,UMShareToWechatTimeline], delegate: self)
    }
    
}

extension ZXY_CourseDetailVC : UMSocialUIDelegate
{
    func didCloseUIViewController(fromViewControllerType: UMSViewControllerType) {
        
    }
    
    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        self.showAlertEasy("提示", messageContent: "\(response.message)")
    }
}
