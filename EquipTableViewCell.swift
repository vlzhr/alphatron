//
//  EquipTableViewCell.swift
//  alphatron
//
//  Created by Anna on 13.04.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class EquipTableViewCell: UITableViewCell {
    // the table cell class that's used by majority of tables (not only equipment table as you could think because of bad title :)) )
    
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
