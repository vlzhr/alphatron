//
//  EquipDetailsViewController.swift
//  alphatron
//
//  Created by Anna on 20.05.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class EquipDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var equipIndex = 0
    var equip: [String: Any] = [:]
    var charsFirst: [String] = ["SerialNumber", "AnnualCheckDate", "Name", "Remarks", "Model", "Marker"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        equip = (Global.fleet[Global.shipNumber]["Equipment"] as! [Any])[equipIndex] as? [String: Any] ?? [:]
        title = equip["Name"] as? String ?? "no name"

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            return charsFirst.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EquipTableViewCell
        if indexPath.row == 0 {
            cell.label1.text = "Serial Number"
            cell.label2.text = String(equip["SerialNumber"] as? Int ?? 0)
        } else if indexPath.row == 1 {
            cell.label1.text = "Check Date"
            cell.label2.text = (equip["CheckDate"] as? String ?? "T").components(separatedBy: "T")[0]
        } else {
            cell.label1.text = charsFirst[indexPath.row]
            cell.label2.text = equip[charsFirst[indexPath.row]] as? String ?? String(describing: equip[charsFirst[indexPath.row]])
        }
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var row = 0
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        row = indexPath.row
        performSegue(withIdentifier: "toEquipEditing", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView = segue.destination as! EditingViewController
        nextView.toEdit = [charsFirst[row], equip[charsFirst[row]] as? String ?? ""]
    }


}