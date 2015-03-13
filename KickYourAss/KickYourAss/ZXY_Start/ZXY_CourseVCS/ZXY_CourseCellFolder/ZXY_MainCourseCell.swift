//
//  ZXY_MainCourseCell.swift
//  KickYourAss
//
//  Created by 宇周 on 15/3/12.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit
let ZXY_MainCourseCellID = "ZXY_MainCourseCellID"
class ZXY_MainCourseCell: UITableViewCell {

    @IBOutlet weak var logoImg: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet var sampleImgs: [UIImageView]!
        
    func setSampleImage(courseImg : [AnyObject]?)
    {
        if let allCourseImg = courseImg
        {
            for (index , value) in enumerate(allCourseImg)
            {
                if(index < sampleImgs.count)
                {
                    var courseImg : ZXYCourseCourse = value as ZXYCourseCourse
                    var imgURL = ZXY_ALLApi.ZXY_MainAPIImage + value.imgPath
                    sampleImgs[index].setImageWithURL(NSURL(string: imgURL))
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
