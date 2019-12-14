//
//  BookTableViewCell.swift
//  MovieTickets
//
//  Created by Nazirul Hasan on 8/12/19.
//  Copyright © 2019 Nazirul Hasan. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet var hallName: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var ticketLabel: UILabel!
    @IBOutlet var premiumLablel: UILabel!
    @IBOutlet var regularLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
