//
//  locationTableViewCell.swift
//  FIT5140-Maybe the last Version
//
//  Created by Burns on 5/9/19.
//  Copyright © 2019 Burns. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
