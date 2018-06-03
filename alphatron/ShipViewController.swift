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
    @IBOutlet weak var view3: UIView!
    
    var shipNumber = 0
    var hasChanged = false
    let border = CALayer()
    
    
    @IBAction func button1(_ sender: Any) {
        view1.isHidden = false
        view2.isHidden = true
//        let color = b1.backgroundColor as! CGColor
//        b1.backgroundColor = UIColor(cgColor: b2.backgroundColor as! CGColor)
//        b2.backgroundColor = UIColor(cgColor: color)
        b2.layer.addSublayer(border)
    }
    
    @IBAction func button2(_ sender: Any) {
        view1.isHidden = true
        view2.isHidden = false
//        let color = b2.backgroundColor as! CGColor
//        b2.backgroundColor = UIColor(cgColor: b1.backgroundColor as! CGColor)
//        b1.backgroundColor = UIColor(cgColor: color)
        b1.layer.addSublayer(border)
    }
    
    @IBAction func onGlobalReset(_ sender: Any) {
        Global.changedFleet[shipNumber] = Global.fleet[shipNumber]
        view3.isHidden = true
        hasChanged = false
        self.tabview1.reloadData()
    }
    
    
    @IBAction func onSave(_ sender: Any) {
        saveData()
        
        let alert = UIAlertController(title: "Request sent", message: "Thanks for sending a request. The data will be changed after approving.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveData() {
        let parameters = Global.changedFleet[shipNumber]//["username": "@kilo_loco", "tweet": "HelloWorld"]
        let link = Global.apiLink + "EditVessel"//"https://jsonplaceholder.typicode.com/posts"
        
        guard let url = URL(string: link) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
    
    
    func saveDataL() {
        let json: [String: Any] = Global.changedFleet[shipNumber]
        let link = Global.apiLink + "EditVessel"
        print(link)
        //let link = "https://gurujsonrpc.appspot.com/guru"
        //let link = "https://jsonplaceholder.typicode.com/posts"
        //let json: [String: Any] = [ "method" : "guru.test", "params" : [ "Guru" ], "id" : 123 ]
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        let url = URL(string: link)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: URL(string: link)!) { (data, response, error) in
            if let content = data {
                do {
                    print(String(bytes: content, encoding: .utf8))
                    let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    print(myJson)
                }
                catch {
                    print("data error")
                }
            }
            else {
                print("ERROR")
            }
        }
        task.resume()
        
    }
    
    
    
    var data: [Int: [String: [String: String]]] = [
        0: ["equipment": ["Gyro #1": "Tokyo Keiki", "Gyro #2": "Tokyo Keiki", "BNWAS": "Furumo"],
            "details": ["Type of vessel": "Cruiseship", "Call Sign": "Alpha", "Gross Tonnage": "180 000"]],
        1: ["equipment": ["Gyro #1": "Amsterdam Keiki", "Gyro #2": "Amsterdam Keiki", "BNWAS": "Uzumaki"],
            "details": ["Type of vessel": "Cruiseship x2", "Call Sign": "Beta", "Gross Tonnage": "75 500"]]
    ]
    
    
    var equipment: [[String: Any]] = []
    
    var details: [String: String] = [:]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            // Return the number of rows in the section.
            if (tableView == view2) {
                print(equipment.count)
                return equipment.count
            }
            else { return details.count }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            if (tableView == view2) {
                let cellIdentifier = "cell"
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EquipTableViewCell
                cell.label1.text = equipment[indexPath.row]["Name"] as? String ?? String(describing: equipment[indexPath.row]["Name"])
                print(equipment[indexPath.row]["Name"])
                cell.label2.text = String(equipment[indexPath.row]["SerialNumber"] as? Int ?? 0)
                return cell
            }
            else {
                let cellIdentifier = "cell"
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShipDetailTableViewCell
                cell.label1.text = Array(details.keys)[indexPath.row]
                if Array(details.values)[indexPath.row] == Global.valuesFromNL(key: Array(details.keys)[indexPath.row]) {
                    cell.label2.text = Array(details.values)[indexPath.row]
                    cell.label3.text = ""
                } else {
                    cell.label3.text = Global.valuesFromNL(key: Array(details.keys)[indexPath.row])
                    cell.label2.text = ""
                    hasChanged = true
                    view3.isHidden = false
                }
                return cell
            }
        }
    
    var toEdit = ["example1", "example2"]
    var equipIndex = 0
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath:
        IndexPath) {
        if tableView == view2 {
            equipIndex = indexPath.row
            performSegue(withIdentifier: "toEquipDetails", sender: self)
        } else {
            toEdit = [Array(details.keys)[indexPath.row], Array(details.values)[indexPath.row]]
            performSegue(withIdentifier: "toEditing", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditing" {
            let nextView = segue.destination as! EditingViewController
            nextView.toEdit = toEdit
        } else {
            let nextView = segue.destination as! EquipDetailsViewController
            nextView.equipIndex = equipIndex
        }
    }
    
    override func viewDidLoad() {
        
        border.backgroundColor = UIColor(red: 255.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1.0).cgColor
        border.frame = CGRect(x: b1.frame.minX, y: b1.frame.maxY, width: b1.frame.width, height: 3.1)
        b2.layer.addSublayer(border)
        view2.isHidden = true
        
        Global.shipNumber = shipNumber
        let ship = Global.fleet[shipNumber]
        title = ship["Name"] as? String ?? ""
        equipment = ship["Equipment"] as? [[String : Any]] ?? []
        print(equipment)
        details = ["Type of vessel": ship["Type"] as! String, "Call Sign": ship["CallSign"] as! String, "Gross Tonnage": String(ship["GrossTonnage"] as? Int ?? 0), "Class": ship["Class"] as! String, "IMO": String(ship["IMO"] as? Int ?? 0), "MMSI": ship["MMSI"] as! String]
        
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.tabview1.reloadData()
        
        if hasChanged {
            view3.isHidden = false
        } else {
            view3.isHidden = true
        }
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

