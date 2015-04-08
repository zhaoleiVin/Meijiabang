//
//  ZXY_MainCourseListVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/3/11.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ZXY_MainCourseListVC: UIViewController {
    @IBOutlet weak var currentTable: UITableView!
    private var dataForTable : ZXYCourseBaseTitle?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLoadData()
        currentTable.addHeaderWithCallback {[weak self] () -> Void in
            self?.currentTable.headerPullToRefreshText = "下拉刷新"
            self?.currentTable.headerReleaseToRefreshText = "松开刷新"
            self?.currentTable.headerRefreshingText    = "正在刷新"
            self?.startLoadData()
            ""
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startLoadData()
    {
        var apiString = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_MainCourseAPI(ZXY_MainCourseAPIType.CourseCategoryList)
        ZXY_NetHelperOperate().startGetDataPost(apiString, parameter: nil, successBlock: {[weak self] (returnDic) -> Void in
            println("LALALALALALALAALALALALALALALAL")
            self?.dataForTable = ZXYCourseBaseTitle(dictionary: returnDic)
            self?.currentTable.reloadData()
            self?.currentTable.headerEndRefreshing()
            return
        }) { (error) -> Void in
            
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

}

extension ZXY_MainCourseListVC : UITableViewDelegate , UITableViewDataSource
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_MainCourseCellID) as ZXY_MainCourseCell
        var currentCourse = dataForTable!.data[indexPath.row] as ZXYCourseData
        var logoURL       = ZXY_ALLApi.ZXY_MainAPIImage + currentCourse.imgPath
        cell.logoImg.setImageWithURL(NSURL(string: logoURL))
        cell.titleLbl.text = currentCourse.cateName
        cell.sampleImgs.map { (imageV) -> Void in
            imageV.image = nil
        }
        cell.setSampleImage(currentCourse.course)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 61
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let datas = dataForTable
        {
            return dataForTable!.data.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        courseDetailListID
        var story   = UIStoryboard(name: "Home", bundle: nil)
        var detailList  = story.instantiateViewControllerWithIdentifier("courseDetailListID") as? ZXY_CourseDetailListVC
        var currentCourse = dataForTable!.data[indexPath.row] as ZXYCourseData
        detailList?.title = currentCourse.cateName
        if(currentCourse.cateId == nil)
        {
            return
        }
        detailList?.setInitData(currentCourse.cateId)
        self.navigationController?.pushViewController(detailList!, animated: true)
    }
    
}
