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
    
    
    
    var equipment = ["Gyro #111", "Gyro #2", "BNWAS"]
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
            let cellIdentifier = "EquipCell"
//            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
//            cell.textLabel?.text = equipment[indexPath.row]
//            cell.imageView?.image = UIImage(named: "waitImage")
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EquipTableViewCell
            cell.label1.text = equipment[indexPath.row]
            cell.label2.text = equipmentLabels[indexPath.row]
            return cell }
    
    
    
    override func viewDidLoad() {
        
        title = "Ship #" + String(1 + shipNumber)
        
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

