//
//  ZXY_VCForWelcome.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/16.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ZXY_VCForWelcome: UIViewController {
    var bmkAuthor : BMKMapManager?
    @IBOutlet weak var backImg: UIImageView!
    
    @IBOutlet weak var clickBtn: UIButton!
    var currentIndex : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(currentIndex != nil)
        {
            if(currentIndex! < 3)
            {
                clickBtn.hidden = true
            }
            else
            {
                clickBtn.hidden = false
                clickBtn.layer.cornerRadius = 4
                clickBtn.layer.masksToBounds = true
                clickBtn.layer.borderColor   = UIColor.whiteColor().CGColor
                clickBtn.layer.borderWidth   = 1
            }
            self.backImg.image = UIImage(named: "\(currentIndex!)JJ")
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func leaveNow(sender: AnyObject) {
        ZXY_UserInfoDetail.sharedInstance.startFirstSuccess()
        var storyBoard = UIStoryboard(name: "Main" , bundle : nil)
        var tvc        = storyBoard.instantiateInitialViewController() as MainViewController
        let dele       = UIApplication.sharedApplication().delegate
        dele!.window!?.rootViewController = tvc
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
