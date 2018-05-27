//
//  DetailsTableDS.swift
//  alphatron
//
//  Created by Anna on 13.04.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit


class DetailsView: UIView, UITableViewDataSource, UITableViewDelegate {
    var details = ["Type of vessel", "Call Sign", "Gross Tonnage"]
    var detailsValues = ["Cruiseship", "Alpha", "180 000"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            // Return the number of rows in the section.
            return details.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cellIdentifier = "EquipCell"
            //            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            //            cell.textLabel?.text = equipment[indexPath.row]
            //            cell.imageView?.image = UIImage(named: "waitImage")
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EquipTableViewCell
            cell.label1.text = details[indexPath.row]
            cell.label2.text = detailsValues[indexPath.row]
            return cell }
    
}
