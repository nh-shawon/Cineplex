//
//  CustomTableViewCell.swift
//  MovieTickets
//
//  Created by Nazirul Hasan on 4/12/19.
//  Copyright © 2019 Nazirul Hasan. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var mImage: UIImageView!
    @IBOutlet var mTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
