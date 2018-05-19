//
//  ShipViewController.swift
//  alphatron
//
//  Created by Anna on 13.04.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class ShipViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UITableView!
    @IBOutlet weak var tabview1: UITableView!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    
    var shipNumber = 0
    let border = CALayer()
    
    
    @IBAction func button1(_ sender: Any) {
        view1.isHidden = false
        view2.isHidden = true
//        let color = b1.backgroundColor as! CGColor
//        b1.backgroundColor = UIColor(cgColor: b2.backgroundColor as! CGColor)
//        b2.backgroundColor = UIColor(cgColor: color)
        b1.layer.addSublayer(border)
    }
    
    @IBAction func button2(_ sender: Any) {
        view1.isHidden = true
        view2.isHidden = false
//        let color = b2.backgroundColor as! CGColor
//        b2.backgroundColor = UIColor(cgColor: b1.backgroundColor as! CGColor)
//        b1.backgroundColor = UIColor(cgColor: color)
        b2.layer.addSublayer(border)
    }
    
    
    var data: [Int: [String: [String: String]]] = [
        0: ["equipment": ["Gyro #1": "Tokyo Keiki", "Gyro #2": "Tokyo Keiki", "BNWAS": "Furumo"],
            "details": ["Type of vessel": "Cruiseship", "Call Sign": "Alpha", "Gross Tonnage": "180 000"]],
        1: ["equipment": ["Gyro #1": "Amsterdam Keiki", "Gyro #2": "Amsterdam Keiki", "BNWAS": "Uzumaki"],
            "details": ["Type of vessel": "Cruiseship x2", "Call Sign": "Beta", "Gross Tonnage": "75 500"]]
    ]
    
    
    var equipment: [String: String] = [:]
    
    var details: [String: String] = [:]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            // Return the number of rows in the section.
            if (tableView == view2) { return equipment.count }
            else { return details.count }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            if (tableView == view2) {
                let cellIdentifier = "cell"
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EquipTableViewCell
                cell.label1.text = Array(equipment.keys)[indexPath.row]
                cell.label2.text = Array(equipment.values)[indexPath.row]
                return cell
            }
            else {
                let cellIdentifier = "cell"
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EquipTableViewCell
                cell.label1.text = Array(details.keys)[indexPath.row]
                cell.label2.text = Array(details.values)[indexPath.row]
                return cell
            }
        }
    
    var toEdit = ["example1", "example2"]
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath:
        IndexPath) {
        toEdit = [Array(details.keys)[indexPath.row], Array(details.values)[indexPath.row]]
        performSegue(withIdentifier: "toEditing", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView = segue.destination as! EditingViewController
        nextView.toEdit = toEdit
    }
    
    override func viewDidLoad() {
        
        border.backgroundColor = UIColor(red: 255.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0).cgColor
        border.frame = CGRect(x: b1.frame.minX, y: b1.frame.maxY, width: b1.frame.width, height: 3.1)
        b1.layer.addSublayer(border)
        view2.isHidden = true
        
        Global.shipNumber = shipNumber
        let ship = Global.fleet[shipNumber]
        title = ship["Name"] as? String ?? ""
        equipment = ship["equipment"] as? [String : String] ?? [:]
        details = ["Type of vessel": ship["Type"] as? String ?? "", "Call Sign": ship["CallSign"] as? String ?? "", "Gross Tonnage": String(ship["GrossTonnage"] as? Int ?? 0)]
        
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

