//
//  ZXY_HomeContainer.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_HomeContainer: UIViewController {

    @IBOutlet weak var courseBtn: UIButton!
    @IBOutlet weak var naviRightBtn: UIButton!
    @IBOutlet weak var naviLeftBtn: UIButton!
    @IBOutlet weak var naviPageC: UIPageControl!
    
    @IBOutlet var naviTitleV: UIView!
    @IBOutlet weak var currentScroll: UIScrollView!
    
    private   var mostFashion : ZXY_HomeMostFashionVC?
    private   var squreHome   : ZXY_HomeSqureVC?
    private   var courseVC    : ZXY_MainCourseListVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startInitTitleNaviView()
        
        //self.startInitTheVC()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.title = "首页"
        super.viewDidAppear(animated)
        self.startInitScrollView()
        self.startInitTheVC()
    }

    func startInitTheVC()
    {
        if(mostFashion == nil)
        {
            var story   = UIStoryboard(name: "Home", bundle: nil)
            mostFashion = story.instantiateViewControllerWithIdentifier("mostVCID") as? ZXY_HomeMostFashionVC
            squreHome   = story.instantiateViewControllerWithIdentifier("squreVCID") as? ZXY_HomeSqureVC
            courseVC    = story.instantiateViewControllerWithIdentifier("courseVCID") as? ZXY_MainCourseListVC
            
            
            self.addChildViewController(mostFashion!)
            self.addChildViewController(squreHome!)
            self.addChildViewController(courseVC!)
            
            self.currentScroll.addSubview(mostFashion!.view)
            mostFashion!.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
            
            self.currentScroll.addSubview(squreHome!.view)
            squreHome!.view.frame   = CGRectMake(self.view.frame.size.width , 0, self.view.frame.size.width, self.view.frame.size.height)
            
            self.currentScroll.addSubview(courseVC!.view)
            courseVC!.view.frame   = CGRectMake(self.view.frame.size.width * 2, 0, self.view.frame.size.width, self.view.frame.size.height)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func startInitScrollView()
    {
        currentScroll.contentSize = CGSizeMake(self.view.frame.size.width * 3, self.view.frame.size.height)
    }
    
    func startInitTitleNaviView()
    {
        self.navigationItem.titleView = naviTitleV
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

extension ZXY_HomeContainer : UIScrollViewDelegate
{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if(scrollView.contentOffset.x == 0)
        {
            self.scrollToChangePage(0)
        }
        else if(scrollView.contentOffset.x == self.view.frame.size.width)
        {
            self.scrollToChangePage(1)
        }
        else
        {
            self.scrollToChangePage(2)
        }
    }
}

extension ZXY_HomeContainer
{
    func scrollToChangePage(currentPage : Int) -> Void
    {
        if(currentPage == 0)
        {
            naviPageC.currentPage = 0
            naviLeftBtn.selected = true
            naviRightBtn.selected = false
            courseBtn.selected    = false
        }
        else if(currentPage == 1)
        {
            naviPageC.currentPage = 1
            naviLeftBtn.selected = false
            naviRightBtn.selected = true
            courseBtn.selected    = false
        }
        else
        {
            naviPageC.currentPage = 2
            naviLeftBtn.selected = false
            naviRightBtn.selected = false
            courseBtn.selected    = true
        }
    }
    @IBAction func rightBtnAction(sender: AnyObject) {
       self.scrollToChangePage(0)
        self.currentScroll.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
    @IBAction func leftBtnAction(sender: AnyObject) {
        self.scrollToChangePage(1)
        self.currentScroll.setContentOffset(CGPointMake(self.view.frame.size.width, 0), animated: true)
    }
    
    @IBAction func courseAction(sender: AnyObject) {
        self.scrollToChangePage(2)
        self.currentScroll.setContentOffset(CGPointMake(self.view.frame.size.width * 2, 0), animated: true)
    }
}
