//
//  ZXY_NailArtistListVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/28.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
enum ZXY_OrderStatus : Int
{
    
    case OrderStatusFasion = 1
    case OrderStatusNearBy = 2
    case OrderStatusRateRank = 3
    case OrderStatusArts     = 4
    
    func titleForOrderStatus(var status : ZXY_OrderStatus) -> String
    {
        switch status
        {
        case .OrderStatusNearBy :
            return "附近"
        case .OrderStatusFasion :
            return "热门"
        case .OrderStatusArts :
            return "作品"
        case .OrderStatusRateRank:
            return "评价"
        default :
            return "热门"
        }
    }
}


class ZXY_NailArtistListVC: UIViewController {

    @IBOutlet weak var currentTable: UITableView!
    private var userListData : NSMutableArray = NSMutableArray()
    private var isDown = false
    private var userCityForFail = "大连市"
    private var currentPage     : Int = 1
    private var currentOrderStatus : ZXY_OrderStatus = .OrderStatusNearBy
    
    @IBOutlet var changeStatusBtn: [UIButton]!
    
    
    @IBOutlet weak var rightBtn : UIButton!
    
    @IBOutlet weak var controlView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentTable.tableFooterView = UIView(frame: CGRectZero)
        currentTable.addFooterWithCallback {[weak self] () -> Void in
            self?.currentTable.footerPullToRefreshText = "上拉加载更多"
            self?.currentTable.footerReleaseToRefreshText = "松开加载"
            self?.currentTable.footerRefreshingText    = "正在加载"
            self?.currentPage++
            self?.startGetArtistListData()
        }
        
        currentTable.addHeaderWithCallback { [weak self] () -> Void in
            self?.currentPage = 1
            self?.currentTable.headerPullToRefreshText = "下拉刷新"
            self?.currentTable.headerReleaseToRefreshText = "松开刷新"
            self?.currentTable.headerRefreshingText    = "正在刷新"
            self?.startGetArtistListData()
        }
        startGetArtistListData()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.rightBtn)
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
            }

    private func startGetArtistListData()
    {
        var cityNameTemp : String? = ZXY_LocationRelative.sharedInstance.sendCityNameToEveryBody()?.addressDetail.city
        if(cityNameTemp == nil)
        {
            cityNameTemp = "大连市"
        }
        if(isDown)
        {
            currentTable.footerEndRefreshing()
            currentTable.headerEndRefreshing()
            return
        }
        isDown = true
        var urlString = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_UserListAPI
        var coor      = ZXY_LocationRelative.sharedInstance.sendLocationToEveryBody()?.coordinate
        if(coor == nil)
        {
            return
        }
        var lat  = coor!.latitude
        var log  = coor!.longitude
        var parameter : Dictionary<String , AnyObject> = ["city" : cityNameTemp! ,
            "user_id" : "" ,
            "lng" : log ,
            "lat" : lat   ,
            "control" : "\(currentOrderStatus.rawValue)" ,
            "p"       : "\(currentPage)"
        ]
        
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: parameter, successBlock: {[weak self] (returnDic) -> Void in
            
            if(self?.currentPage == 1)
            {
                self?.userListData.removeAllObjects()
                self?.userListData.addObjectsFromArray(ZXYArtistListBase(dictionary: returnDic).data)
            }
            else
            {
                self?.userListData.addObjectsFromArray(ZXYArtistListBase(dictionary: returnDic).data)
            }
            
//            var artistList : [ZXYArtistListData] = self?.userListData as [ZXYArtistListData]
//            
//            artistList.map({[weak self] (currentArt) -> Void in
//                ZXY_DataProvider().saveArt(currentArt.nickName, artID: currentArt.userId, artImg: currentArt.headImage)
//                return
//            })
            
            for var i = 0 ; i < self?.userListData.count ; i++
            {
                var currentUser : ZXYArtistListData? = self?.userListData[i] as? ZXYArtistListData
                
                if(currentUser != nil)
                {
                    ZXY_DataProvider().saveArt(currentUser!.nickName, artID: currentUser!.userId, artImg: currentUser!.headImage)

                }
            }
            
            self?.reloadTableView()
            self?.currentTable.footerEndRefreshing()
            self?.currentTable.headerEndRefreshing()
            self?.isDown = false
            }, failBlock: { [weak self](error) -> Void in
                self?.currentTable.footerEndRefreshing()
                self?.currentTable.headerEndRefreshing()
                self?.isDown = false
            println(error)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ZXY_NailArtistListVC: UITableViewDelegate , UITableViewDataSource
{
    func reloadTableView()
    {
        self.currentTable.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var currentRow = indexPath.row
        var currentSection = indexPath.section
        var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_ArtistListCellID) as ZXY_ArtistListCell
        var currentArtist : ZXYArtistListData = userListData[currentRow] as ZXYArtistListData
        cell.nameLbl.text  = currentArtist.nickName
        cell.numOfArt.text = "作品：\(currentArtist.albumCount)"
        cell.likeNumLbl.text = currentArtist.byAttention
        
        var headImg = ZXY_ALLApi.ZXY_MainAPIImage + currentArtist.headImage
        if(currentArtist.headImage.hasPrefix("http"))
        {
            headImg = currentArtist.headImage
        }
        var coor = ZXY_LocationRelative.sharedInstance.sendLocationToEveryBody()?.coordinate
        var artistL      = self.xYStringToCoor(currentArtist.longitude, latitude: currentArtist.latitude)
        if(coor != nil)
        {
            var lat  = coor!.latitude
            var log  = coor!.longitude
            var distance = self.distanceCompareCoor(artistL, userPosition: coor)
            cell.distanceLbl.text = "\(Double(round(100 * distance)/100)) km"

        }
        else
        {
            cell.distanceLbl.text = "没有获取到位置信息"
        }
        
        
        
        cell.setHeadImageURL(NSURL(string: headImg))
        cell.setRateValue((currentArtist.score as NSString).integerValue)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 99
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListData.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var story  = UIStoryboard(name: "ArtistDetailStoryBoard", bundle: nil)
        var currentArtist : ZXYArtistListData = userListData[indexPath.row] as ZXYArtistListData
        var vc     = story.instantiateViewControllerWithIdentifier(ZXY_ArtistDetailVCID) as ZXY_ArtistDetailVC
        vc.setUserID(currentArtist.userId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ZXY_NailArtistListVC
{
    func distanceCompareCoor(artistPosition : CLLocationCoordinate2D? , userPosition : CLLocationCoordinate2D?) -> Double
    {
        if(artistPosition != nil && userPosition != nil)
        {
            var artistPot = BMKMapPointForCoordinate(artistPosition!)
            var userPot   = BMKMapPointForCoordinate(userPosition!)
            var distance  = BMKMetersBetweenMapPoints(artistPot, userPot)
            return distance/1000
        }
        else
        {
            return 0
        }
        
    }
    
    func  xYStringToCoor(longitude : String? , latitude: String?) -> CLLocationCoordinate2D?
    {
        if(longitude == nil || latitude == nil)
        {
            return nil
        }
        else
        {
            var logFloat = (longitude! as NSString).doubleValue
            var latFloat = (latitude!  as NSString).doubleValue
            return CLLocationCoordinate2DMake(latFloat, logFloat)
        }
        
    }
    
    @IBAction func ClickRightBtnAction(sender: AnyObject)
    {
        var btn : UIButton = sender as UIButton
        
        if(btn.selected)
        {
            btn.selected = false
            hideControlView()
        }
        else
        {
            btn.selected = true
            showControlView()
        }
    }
    
    func showControlView()
    {
        UIView.animateWithDuration(0.2, animations: {[weak self] () -> Void in
            self?.controlView.alpha = 1
            return
        })
    }
    
    func hideControlView()
    {
        UIView.animateWithDuration(0.2, animations: {[weak self] () -> Void in
            self?.controlView.alpha = 0
            return
        })
    }
    
    @IBAction func changeOrderStatusAction(sender: AnyObject) {
        var currentBtn : UIButton = sender as UIButton
        for (index , value) in enumerate(changeStatusBtn)
        {
            if(value == currentBtn)
            {
                switch index
                {
                case 0 :
                    currentOrderStatus = ZXY_OrderStatus.OrderStatusFasion
                case 1 :
                    currentOrderStatus = ZXY_OrderStatus.OrderStatusNearBy
                case 2 :
                    currentOrderStatus = ZXY_OrderStatus.OrderStatusRateRank
                case 3 :
                    currentOrderStatus = ZXY_OrderStatus.OrderStatusArts
                default:
                    currentOrderStatus = ZXY_OrderStatus.OrderStatusFasion
                }
                currentPage = 1
                self.startGetArtistListData()
                self.hideControlView()
                self.startReloadRightBtn()
                self.rightBtn.selected = false
                return
            }
        }
    }
    
    func startReloadRightBtn()
    {
        switch currentOrderStatus
        {
        case ZXY_OrderStatus.OrderStatusFasion :
            rightBtn.setTitle("热门", forState: UIControlState.Normal)
        case ZXY_OrderStatus.OrderStatusNearBy :
            rightBtn.setTitle("附近", forState: UIControlState.Normal)
        case ZXY_OrderStatus.OrderStatusRateRank :
            rightBtn.setTitle("评价", forState: UIControlState.Normal)
        case ZXY_OrderStatus.OrderStatusArts :
            rightBtn.setTitle("作品", forState: UIControlState.Normal)
        default :
            rightBtn.setTitle("热门", forState: UIControlState.Normal)
            
        }
    }
    

}
