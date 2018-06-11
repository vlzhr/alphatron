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
    var charsFirst: [String] = ["SerialNumber", "CheckDate", "Remarks", "Name", "Model", "Maker"]

    func saveData() {
        let parameters = (Global.changedFleet[Global.shipNumber]["Equipment"] as! [[String: Any]])[Global.equipNumber]
        let link = Global.apiLink + "EditVessel"
        
        guard let url = URL(string: link) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        guard let newObj = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        var postString = "user_id=" + String(Global.userID)
        postString += "&token=" + Global.token + "&newobj=" + (String(data: newObj, encoding: .utf8) as? String ?? "")
        print(postString)
        request.httpBody = postString.data(using: .utf8)
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            }.resume()
    }
    
    @IBOutlet weak var view3: UIView!
    
    @IBAction func onReset(_ sender: Any) {
        Global.changedFleet[Global.shipNumber]["Equipment"] = Global.fleet[Global.shipNumber]["Equipment"]
        view3.isHidden = true
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        equip = (Global.fleet[Global.shipNumber]["Equipment"] as! [Any])[equipIndex] as? [String: Any] ?? [:]
        title = equip["Name"] as? String ?? "no name"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view3.isHidden = true
        let changedEquip = (Global.changedFleet[Global.shipNumber]["Equipment"] as! [Any])[equipIndex] as? [String: Any] ?? [:]
        for n in Array(equip.keys) {
            if equip[n] as? String ?? String(equip[n] as? Int ?? 0) != changedEquip[n] as? String ?? String(changedEquip[n] as? Int ?? 0) {
                self.view3.isHidden = false
            }
        }
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
        } else if indexPath.row == 2 {
            cell.label1.text = "Remarks"
            cell.label2.text = (equip["Remarks"] as? String ?? "-")
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
        nextView.toEdit = [charsFirst[row], equip[charsFirst[row]] as? String ?? String(equip[charsFirst[row]] as? Int ?? 0)]
    }


}
