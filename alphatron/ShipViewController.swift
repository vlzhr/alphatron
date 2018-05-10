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
    
    @IBAction func button1(_ sender: Any) {
        view1.isHidden = false
        view2.isHidden = true
//        let color = b1.backgroundColor as! CGColor
//        b1.backgroundColor = UIColor(cgColor: b2.backgroundColor as! CGColor)
//        b2.backgroundColor = UIColor(cgColor: color)
    }
    
    @IBAction func button2(_ sender: Any) {
        view1.isHidden = true
        view2.isHidden = false
//        let color = b2.backgroundColor as! CGColor
//        b2.backgroundColor = UIColor(cgColor: b1.backgroundColor as! CGColor)
//        b1.backgroundColor = UIColor(cgColor: color)
    }
    
    
    var data: [Int: [String: [String: String]]] = [
        0: ["equipment": ["Gyro #1": "Tokyo Keiki", "Gyro #2": "Tokyo Keiki", "BNWAS": "Furumo"],
            "details": ["Type of vessel": "Cruiseship", "Call Sign": "Alpha", "Gross Tonnage": "180 000"]],
        1: ["equipment": ["Gyro #1": "Amsterdam Keiki", "Gyro #2": "Amsterdam Keiki", "BNWAS": "Uzumaki"],
            "details": ["Type of vessel": "Cruiseship x2", "Call Sign": "Beta", "Gross Tonnage": "75 500"]]
    ]
    
    var names: [Int: String] = [
        0: "Ship #1",
        1: "Ship #2"
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
    
    
    
    override func viewDidLoad() {
        
        //self.view2.register(UITableView.self, forCellReuseIdentifier: "cell")
        //self.tabview1.register(UITableView.self, forCellReuseIdentifier: "cell")
        
        title = names[shipNumber]
        equipment = (data[shipNumber]?["equipment"])!
        details = (data[shipNumber]?["details"])!
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

