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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let link = Global.apiLink + "CompaniesVessels?user_id=6&id=1&token=" + Global.token
        
        DispatchQueue.main.async {
            let task = URLSession.shared.dataTask(with: URL(string: link)!) { (data, response, error) in
                if let content = data {
                    do {
                        let fleet = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        print(fleet)
                        Global.fleet = fleet as! [[String : Any]]
                        

                        var n = 0
                        while n < Global.fleet.count {
                            self.ships[Global.fleet[n]["Name"] as? String ?? ""] = Global.fleet[n]["IMO"] as? Int ?? 0
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
    
    
    var ships: [String: Int] = [:]//["Ship #1": "2564110", "Ship #2": "1452383"];
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            // Return the number of rows in the section.
            return ships.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cellIdentifier = "TableCell"
            //            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            //            cell.textLabel?.text = equipment[indexPath.row]
            //            cell.imageView?.image = UIImage(named: "waitImage")
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EquipTableViewCell
            cell.label1.text = Array(ships.keys)[indexPath.row]
            cell.label2.text = "IMO: " + String(Array(ships.values)[indexPath.row])
            return cell }
    
    var rowselected = Int()
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath:
        IndexPath) {
        rowselected = indexPath.row
        print(rowselected)
        print(Global.fleet[rowselected]["IMO"])
        performSegue(withIdentifier: "toShip", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView = segue.destination as! ShipViewController
        nextView.shipNumber = rowselected
    }
    
    
    
    @IBOutlet var imageExample: UIView!
    
    

}
