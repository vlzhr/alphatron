//
//  EditingViewController.swift
//  alphatron
//
//  Created by Anna on 19.05.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class EditingViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    var toEdit: [String] = ["", ""]
    var wasEdited: String? = nil
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var labelChanged: UILabel!
    @IBOutlet weak var valueField: UITextField!
    
    @IBAction func onEdit(_ sender: Any) {
        let value = valueField.text
        if value != toEdit[1] {
            labelChanged.text = value
            Global.changeFleetWithNL(key: toEdit[0], value: value ?? "")
            view2.isHidden = false
        }
    }
    @IBAction func onReset(_ sender: Any) {
        print(Global.valuesFromNL(key: toEdit[0]))
        Global.changeFleetWithNL(key: toEdit[0], value: toEdit[1])
        print(Global.valuesFromNL(key: toEdit[0]))
        view2.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label1.text = toEdit[0]
        valueField.text = toEdit[1]
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if toEdit[1] == Global.valuesFromNL(key: toEdit[0]) {
            print("not changed")
        } else {
            print(toEdit[1])
            print(Global.valuesFromNL(key: toEdit[0]))
            labelChanged.text = Global.valuesFromNL(key: toEdit[0])
            view2.isHidden = false
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
