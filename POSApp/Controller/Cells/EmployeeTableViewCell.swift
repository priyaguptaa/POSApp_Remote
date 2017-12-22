//
//  EmployeeTableViewCell.swift
//  POSApp
//
//  Created by PriyaMac on 14/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var labelRate: UILabel!
    @IBOutlet weak var labelHourly: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelContact: UILabel!
    @IBOutlet weak var labelRole: UILabel!
    @IBOutlet weak var labelPassword: UILabel!
    @IBOutlet weak var labelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
