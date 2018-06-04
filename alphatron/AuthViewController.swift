//
//  AuthViewController.swift
//  alphatron
//
//  Created by Anna on 14.05.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

struct Global {
    static let apiLink = "http://alphatron.schander-dev.art/API/"
    static let mediaLink = "http://alphatron.schander-dev.art"
    static var auth = false
    static var token = ""
    static var userID = 0
    static var shipNumber = 0
    static var user: [String: Any] = [:]
    static var fleet: [[String: Any]] = []
    static var changedFleet: [[String: Any]] = []
    static func valuesFromNL(key: String) -> String {
        switch (key) {
            case "Type of vessel":
                return self.changedFleet[self.shipNumber]["Type"] as! String
            case "Call Sign":
                return self.changedFleet[self.shipNumber]["CallSign"] as! String
            case "Gross Tonnage":
                return String(self.changedFleet[self.shipNumber]["GrossTonnage"] as? Int ?? 0)
            case "IMO":
                return String(self.changedFleet[self.shipNumber]["IMO"] as? Int ?? 0)
            case "MMSI":
                return self.changedFleet[self.shipNumber]["MMSI"] as! String
            case "Class":
                return self.changedFleet[self.shipNumber]["Class"] as! String
        default:
            return "p"
        }
    }
    static func changeFleetWithNL(key: String, value: String) -> Void {
        switch (key) {
        case "Type of vessel":
            self.changedFleet[self.shipNumber]["Type"] = value
        case "Call Sign":
            self.changedFleet[self.shipNumber]["CallSign"] = value
        case "Gross Tonnage":
            self.changedFleet[self.shipNumber]["GrossTonnage"] = Int(value)
        case "IMO":
            self.changedFleet[self.shipNumber]["IMO"] = Int(value)
        case "MMSI":
            self.changedFleet[self.shipNumber]["MMSI"] = value
        case "Class":
            self.changedFleet[self.shipNumber]["Class"] = value
        default:
            print("key not found")
        }
    }
    static let toSys: [String: String] = ["Type of vessel": "Type", "Call Sign": "CallSign", "Gross Tonnage": "GrossTonnage"]
}

class AuthViewController: UIViewController {
    
    func continueToFleet() -> Void {
        self.performSegue(withIdentifier: "toFleet", sender: self)
        
    }
    
    func auth(login: String, password: String) {
        let link = Global.apiLink + "APIAuth?email=" + login + "&password=" + MD5(string: password)
        print(link)
        let task = URLSession.shared.dataTask(with: URL(string: link)!) { (data, response, error) in
            if let content = data {
                do {
                    let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    print(myJson)
                    Global.user = myJson["User"] as? [String : Any] ?? [:]
                    Global.token = myJson["Token"] as? String ?? "error"
                    Global.userID = (myJson["User"] as? [String: Any] ?? [:])["ID"] as? Int ?? 1
                    Global.auth = true
                    
                    DispatchQueue.main.async {
                        self.continueToFleet()
                    }
                }
                catch {
                    self.showDataError()
                }
            }
            else {
                print("ERROR")
            }
        }
        task.resume()
    }
    
    func showDataError() {
        let alert = UIAlertController(title: "Data incorrect!", message: "Ooops.. Check the data you have inserted. Here goes a mistake.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }}))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func onDataInsert() {
        auth(login: login.text ?? "", password: password.text ?? "")
    }
    
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginBut(_ sender: Any) {
        onDataInsert()
        password.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Global.auth {
            continueToFleet()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //if Global.auth {
        //    continueToFleet()
        //} else {
        //    print("let's login!")
        //    auth(login: "test@gmail.com", password: "tes2t")
        //}
    }

    override func viewWillAppear(_ animated: Bool) {
        if Global.auth {
            continueToFleet()
        } else {
            print("let's login!")
            //auth(login: "test@gmail.com", password: "test")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func MD5(string: String) -> String {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }

}
