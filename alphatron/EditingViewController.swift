//
//  EditingViewController.swift
//  alphatron
//
//  Created by Anna on 19.05.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class EditingViewController: UIViewController {

    var toEdit: [String: String] = ["": ""]
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var valueField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label1.text = Array(toEdit.keys)[0]
        valueField.text = Array(toEdit.values)[0]
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
