//
//  ZXYOrderToMeCell.swift
//  KickYourAss
//
//  Created by 宇周 on 15/3/14.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ZXYOrderToMeCell: UITableViewCell {

    @IBOutlet weak var apTimeLabel: UILabel!
    @IBOutlet weak var cusNameLabel: UILabel!
    @IBOutlet weak var apLocationLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var statusNewImage: UIImageView!
    
    var showNew: Bool = false {
        didSet {
            statusNewImage.hidden = !showNew
            statusLabel.hidden = showNew
        }
    }
    
    class var identifier: String {
        return "ZXYOrderToMeCellIdentifier"
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
