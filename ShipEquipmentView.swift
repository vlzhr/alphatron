//
//  ShipEquipmentView.swift
//  alphatron
//
//  Created by Anna on 13.04.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class ShipEquipmentView: UITableView, UITableViewDataSource {
    
    let equipment = ["vova", "levca"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            // Return the number of rows in the section.
            return equipment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cellIdentifier = "Cell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            // Configure the cell...
            cell.textLabel?.text = equipment[indexPath.row]
            return cell }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
