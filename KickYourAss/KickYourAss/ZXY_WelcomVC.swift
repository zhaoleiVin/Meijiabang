//
//  ZXY_WelcomVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/16.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ZXY_WelcomVC: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let startPage = self.storyboard?.instantiateViewControllerWithIdentifier("haha") as ZXY_VCForWelcome
        startPage.currentIndex = 0
        self.setViewControllers([startPage], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        self.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension ZXY_WelcomVC : UIPageViewControllerDataSource
{
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = (self.viewControllers.first as ZXY_VCForWelcome).currentIndex!
        if currentIndex >= 3 {
            return nil
        } else {
            let nextPage = self.storyboard?.instantiateViewControllerWithIdentifier("haha") as ZXY_VCForWelcome
            nextPage.currentIndex = currentIndex + 1
            return nextPage
        }
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = (self.viewControllers.first as ZXY_VCForWelcome).currentIndex!
        if currentIndex <= 0 {
            return nil
        } else {
            let previousPage = self.storyboard?.instantiateViewControllerWithIdentifier("haha") as ZXY_VCForWelcome
            previousPage.currentIndex = currentIndex - 1
            return previousPage
        }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 4
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
