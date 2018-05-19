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
    static var auth = true
    static var token = "e0be339948dd9d1a071ef8d15d5e5eb2d001585c"
    static var companyID = 1
    static var userID = 6
    static var fleet: [[String: Any]] = []
}

class AuthViewController: UIViewController {
    
    func continueToFleet() -> Void {
        
        self.performSegue(withIdentifier: "toFleet", sender: self)
        
    }
    
//    func auth() {
//        let passMD5 = "098F6BCD4621D373CADE4E832627B4F6"
//        let link = Global.apiLink
//        let task = URLSession.shared.dataTask(with: URL(string: link)!) { (data, response, error) in
//            
//            if let content = data {
//                
//                do {
//                    let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
//                }
//                catch {
//                    print("err")
//                }
//                
//            }
//            else {
//                print("ERROR")
//            }
//            
//        }
////    }
    
    
    func onDataInsert() {
        if (login.text == "test@gmail.com") && (password.text == "test") {
            Global.auth = true
            continueToFleet()
        }
        else {
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
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!

    @IBAction func afterLoginField(_ sender: Any) {
        print("he")
    }
    
    @IBAction func loginBut(_ sender: Any) {
        onDataInsert()
        password.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Global.auth = false
        //if Global.auth {
        //    continueToFleet()
        //}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Global.auth {
            continueToFleet()
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
