//
//  ProductsTableViewCell.swift
//  alphatron
//
//  Created by Anna on 23.05.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var image1: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
