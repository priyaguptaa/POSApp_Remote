//
//  CategoryTableViewCell.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 04/12/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var labelCategoryName: UILabel!
    @IBOutlet weak var labelNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelNo.text = Localizator.instance.localize(string: "key_no")
        labelCategoryName.text = Localizator.instance.localize(string: "key_name")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
