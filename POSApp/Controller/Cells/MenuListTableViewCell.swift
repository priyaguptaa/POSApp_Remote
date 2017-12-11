//
//  MenuListTableViewCell.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 04/12/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class MenuListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var labelGst: DesignableLabel!
    @IBOutlet weak var labelPrice: DesignableLabel!
    @IBOutlet weak var labelSpecial: DesignableLabel!
    @IBOutlet weak var labelName: DesignableLabel!
    @IBOutlet weak var labelNo: DesignableLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
