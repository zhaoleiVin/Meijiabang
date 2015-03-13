//
//  ZXY_CourseDetailListCell.swift
//  KickYourAss
//
//  Created by 宇周 on 15/3/12.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit
let ZXY_CourseDetailListCellID = "ZXY_CourseDetailListCellID"
class ZXY_CourseDetailListCell: UITableViewCell {

    @IBOutlet weak var headerImg: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var describLbl: UILabel!
    
    @IBOutlet weak var numOfFavor: UILabel!
    
    @IBOutlet weak var numOfCollect: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        numOfCollect.textColor = ZXY_AllColor.SEARCH_RED_COLOR
        numOfFavor.textColor   = ZXY_AllColor.SEARCH_RED_COLOR
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
