//
//  UserProfileTableViewCell.swift
//  POSApp
//
//  Created by priya gupta on 08/12/17.
//  Copyright © 2017 priya gupta. All rights reserved.
//

import UIKit

class UserProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var labelEmailAddress: UILabel!
    @IBOutlet weak var labelLastName: UILabel!
    @IBOutlet weak var labelFirstName: UILabel!
    @IBOutlet weak var imageViewUserProfile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageViewUserProfile.layer.cornerRadius = imageViewUserProfile.layer.frame.height/2
        imageViewUserProfile.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
