//
//  ShipEquipmentViewController.swift
//  alphatron
//
//  Created by Anna on 18.04.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class ShipEquipmentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var equipment = ["Gyro #1", "Gyro #2", "BNWAS"]
    var equipmentLabels = ["Tokyo Keiki", "Tokyo Keiki", "Furumo"]
    
    var details = ["Type of vessel", "Call Sign", "Gross Tonnage"]
    var detailsValues = ["Cruiseship", "Alpha", "180 000"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            // Return the number of rows in the section.
            return equipment.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cellIdentifier = "EquipCharCell"
            //            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            //            cell.textLabel?.text = equipment[indexPath.row]
            //            cell.imageView?.image = UIImage(named: "waitImage")
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EquipTableViewCell
            cell.label1.text = equipment[indexPath.row]
            cell.label2.text = equipmentLabels[indexPath.row]
            return cell }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
