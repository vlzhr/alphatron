//
//  ContactViewController.swift
//  alphatron
//
//  Created by Anna on 27.05.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet weak var thanksView: UIView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var guestView: UIView!

    @IBOutlet weak var userMail: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userRole: UILabel!
    @IBOutlet weak var userCompany: UILabel!
    
    var contactViewStartY: CGFloat = 337.0
    
    @IBAction func onCall(_ sender: Any) {
        guard let number = URL(string: "tel://+31104534000") else { return }
        UIApplication.shared.open(number)
    }
    
    @IBAction func onLogout(_ sender: Any) {
        Global.auth = false
        viewDidAppear(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //contactViewStartY = contactView.frame.size.height
        thanksView.layer.shadowColor = UIColor.red.cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !Global.auth {
            guestView.isHidden = true
            
            contactView.frame = CGRect( x: (UIScreen.main.bounds.size.width-contactView.frame.size.width)/2, y: 90, width: contactView.frame.size.width, height: contactView.frame.size.height )
        } else {
            guestView.isHidden = false
            contactView.frame = CGRect( x: (UIScreen.main.bounds.size.width-contactView.frame.size.width)/2, y: contactViewStartY, width: contactView.frame.size.width, height: contactView.frame.size.height )
            userMail.text = Global.user["Email"] as? String ?? ""
            userName.text = Global.user["Name"] as? String ?? ""
            userCompany.text = (Global.user["Company"] as? [String: Any] ?? [:])["Name"] as? String ?? ""
            userRole.text = (Global.user["Roles"] as? [String: Any] ?? [:])["Name"] as? String ?? ""
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
