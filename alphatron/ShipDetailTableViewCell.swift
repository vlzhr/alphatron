//
//  ShipDetailTableViewCell.swift
//  alphatron
//
//  Created by Anna on 19.05.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class ShipDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
