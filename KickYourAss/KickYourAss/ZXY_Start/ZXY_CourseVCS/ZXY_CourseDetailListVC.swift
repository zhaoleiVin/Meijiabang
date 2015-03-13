//
//  ZXY_CourseDetailListVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/3/12.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ZXY_CourseDetailListVC: UITableViewController {

    private var cateID : String!
    private var dataForTable : ZXYCourseDetailListBase?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLoadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func setInitData(cate_ID : String)
    {
        self.cateID = cate_ID
    }
    
    func startLoadData()
    {
        var stringForURL =  ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_MainCourseAPI(ZXY_MainCourseAPIType.CourseDetailList)
        var parameter    = ["cate_id" : self.cateID]
        ZXY_NetHelperOperate().startGetDataPost(stringForURL, parameter: parameter, successBlock: { [weak self] (returnDic) -> Void in
            
            self?.dataForTable = ZXYCourseDetailListBase(dictionary: returnDic)
            var resultDouble   = self?.dataForTable?.result
            var resultString   = "\(Int(resultDouble!))"
            if(ZXY_ErrorMessageHandle.resultCodeIsSuccess(resultString))
            {
                self?.tableView.reloadData()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if let num = dataForTable?.data.count
        {
            return num
        }
        else
        {
            return 0
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell           = tableView.dequeueReusableCellWithIdentifier(ZXY_CourseDetailListCellID, forIndexPath:                  indexPath) as ZXY_CourseDetailListCell
        
        var currentData    = self.dataForTable?.data[indexPath.row] as ZXYCourseDetailListData
        cell.titleLbl.text = currentData.title
        cell.describLbl.text = currentData.desc
        var stringURL = ZXY_ALLApi.ZXY_MainAPIImage + currentData.imgPath
        cell.headerImg.setImageWithURL(NSURL(string: stringURL))
        cell.numOfFavor.text = currentData.collectNum
        cell.numOfCollect.text = currentData.starNum
        // Configure the cell...

        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var story   = UIStoryboard(name: "Home", bundle: nil)
        var detailList  = story.instantiateViewControllerWithIdentifier("courseDetailVCID") as? ZXY_CourseDetailVC
        var currentData: ZXYCourseDetailListData   = self.dataForTable?.data[indexPath.row] as ZXYCourseDetailListData
        detailList?.setInitDataID(currentData.dataIdentifier)
        detailList?.title = currentData.title
        self.navigationController?.pushViewController(detailList!, animated: true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
