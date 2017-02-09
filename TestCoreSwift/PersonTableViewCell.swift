//
//  PersonTableViewCell.swift
//  TestCoreSwift
//
//  Created by Bindu on 25/01/17.
//  Copyright © 2017 Xminds. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var jobLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
        @IBOutlet var userImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
