//
//  FleetViewController.swift
//  alphatron
//
//  Created by Anna on 10.03.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class FleetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /* let fleet = loadFleet(uid: 0)
        
        for (n, ship) in fleet.enumerated() {
            let yDist = 30+(n+1)*220
         
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            label.center = CGPoint(x: 160, y: yDist)
            label.textAlignment = .left
            label.text = ship["name"]
            self.view.addSubview(label)
            
            
            
            let catPictureURL = URL(string: ship["image"]!)!
            let session = URLSession(configuration: .default)
            let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
                if let e = error {
                    print("Error downloading cat picture: \(e)")
                } else {
                    // No errors found.
                    // It would be weird if we didn't have a response, so check for that too.
                    if let res = response as? HTTPURLResponse {
                        print("Downloaded cat picture with response code \(res.statusCode)")
                        if let imageData = data {
                            // Finally convert that Data into an image and do what you wish with it.
                            let image = UIImage(data: imageData)
                            let imageView = UIImageView(image: image!)
                            imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
                            imageView.center = CGPoint(x: 80, y: yDist+90)
                            self.view.addSubview(imageView)
                            // Do something with your image.
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code for some reason")
                    }
                }
            }
            
            downloadPicTask.resume()
            
        }
        */
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    let ships = ["Ship #1", "Ship #2"];
    let shipsNumbers = ["IMO: 2564110", "IMO: 1452383"];
    
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
            cell.label1.text = ships[indexPath.row]
            cell.label2.text = shipsNumbers[indexPath.row]
            return cell }
    
    var rowselected = Int()
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath:
        IndexPath) {
        rowselected = indexPath.row
        performSegue(withIdentifier: "toShip", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView = segue.destination as! ShipViewController
        nextView.shipNumber = rowselected
    }
    
    
    
    @IBOutlet var imageExample: UIView!
    
    func loadFleet(uid: Int) -> [[String: String]] {
        // here is parsing !!!
        let fleet: [[String: String]] = [["image": "https://0.gravatar.com/avatar/673bb041c088d72c449e51515d8a21ad?s=96", "name": "Ship #1", "imo": "9241062"],
                                         ["image": "https://0.gravatar.com/avatar/673bb041c088d72c449e51515d8a21ad?s=96", "name": "Ship #2", "imo": "6775301"]]
        return fleet
    }
    

}
