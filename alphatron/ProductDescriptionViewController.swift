//
//  ProductDescriptionViewController.swift
//  alphatron
//
//  Created by Vladimir Zhuravlev on 14/07/2018.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class ProductDescriptionViewController: UIViewController {

    var product: [String: Any] = [:]
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = product["Name"] as? String ?? ""
        descText.text = product["FullDescription"] as? String ?? ""
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
