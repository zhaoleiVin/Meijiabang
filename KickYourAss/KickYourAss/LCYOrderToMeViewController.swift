//
//  LCYOrderToMeViewController.swift
//  KickYourAss
//
//  Created by eagle on 15/2/11.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class LCYOrderToMeViewController: LCYOrderBaseViewController {
    private var dataInfo : CYMJOrderListBase?
    
    override func reload() {
        let parameter = [
            "user_id": LCYCommon.sharedInstance.userInfo!.userID,
            "role": LCYCommon.sharedInstance.userInfo!.role,
            "p": "1"
        ]
        LCYNetworking.sharedInstance.POST(
            Api: LCYNetworking.LCYApi.OrderList,
            parameters: parameter,
            success: { [weak self](object) -> Void in
                self?.dataInfo = CYMJOrderListBase.modelObjectWithDictionary(object)
                var resultStatus = self?.dataInfo?.result
                if resultStatus == 1000 {
                    
                    self?.tableView.reloadData()
                } else {
                    self?.alertWithErrorCode(resultStatus!)
                }
                return
            },
            { [weak self]() -> Void in
                self?.alertNetworkFailed()
                return
        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tempData = dataInfo
        {
            return tempData.data.count
        }
        
        return 0
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ZXYOrderToMeCell.identifier) as ZXYOrderToMeCell
        let data = dataInfo?.data[indexPath.row] as CYMJOrderListData
        cell.apTimeLabel.text = data.addTime.stringFromTimeStamp(format: "yyyy-MM-dd HH:mm:ss")
        cell.cusNameLabel.text = data.nickName
        cell.apLocationLabel.text = data.detailAddr
        cell.statusLabel.text = LCYCommon.sharedInstance.orderStatus(data.orderStatus)
        cell.showNew = data.orderStatus == "1"
        return cell
    }
}
