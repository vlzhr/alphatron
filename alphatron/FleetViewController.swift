//
//  FleetViewController.swift
//  alphatron
//
//  Created by Anna on 10.03.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class FleetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tb: UITableView!
    
    @IBOutlet weak var noAccessWindow: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (Global.auth == false) {
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if (Global.userRole == 3) {
            tb.isHidden = true
            return
        } else {
            
        }
        
        tb.isHidden = false
        
        let link = Global.apiLink + "UsersVessels?user_id=" + String(Global.userID) + "&id=" + String(Global.userID) + "&token=" + Global.token
        print(link)
        
        DispatchQueue.main.async {
            let task = URLSession.shared.dataTask(with: URL(string: link)!) { (data, response, error) in
                if let content = data {
                    do {
                        let fleet = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        print(fleet)
                        Global.fleet = fleet as! [[String : Any]]
                        Global.changedFleet = fleet as! [[String : Any]]
                        

                        var n = 0
                        while n < Global.fleet.count {
                            let date = (Global.fleet[n]["AnnualCheckDate"] as? String ?? "T").components(separatedBy: "T")[0]
                            self.ships.append([Global.fleet[n]["Name"] as? String ?? "" : date])
                            n += 1
                        }
                        print(self.ships)
                        
                        DispatchQueue.main.async {
                            self.tb.reloadData()
                        }
                        
                    }
                    catch {
                        print("err")
                    }
                }
            }
            
            task.resume()
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var ships: [[String: String]] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            // Return the number of rows in the section.
            return ships.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cellIdentifier = "TableCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EquipTableViewCell
            cell.label1.text = Array(ships[indexPath.row].keys)[0]
            cell.label2.text = "Check on " + Array(ships[indexPath.row].values)[0]
            //cell.label2.text = "IMO: " + String(Array(ships[indexPath.row].values)[0])
            return cell }
    
    var shipSelected = Int()
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath:
        IndexPath) {
        shipSelected = indexPath.row
        performSegue(withIdentifier: "toShip", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView = segue.destination as! ShipViewController
        nextView.shipNumber = shipSelected
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet var imageExample: UIView!
    
    

}
