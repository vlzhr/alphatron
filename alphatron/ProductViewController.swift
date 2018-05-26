//
//  ProductViewController.swift
//  alphatron
//
//  Created by Anna on 26.05.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shortDescText: UILabel!
    @IBOutlet weak var bulletTab: UITableView!
    @IBOutlet weak var fullDescText: UITextView!
    var product: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = product["Name"] as? String ?? ""
        shortDescText.text = product["ShortDescription"] as? String ?? ""
        fullDescText.text = product["FullDescription"] as? String ?? ""
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            return (product["ProductBulletFact"] as? [String] ?? []).count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductBulletTableViewCell
        cell.label1.text = (product["ProductBulletFact"] as? [String] ?? [])[indexPath.row]
        return cell
    }

}
