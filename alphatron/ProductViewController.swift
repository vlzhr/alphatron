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
    @IBOutlet weak var button1: UIButton!
    @IBAction func onDownloadManualClick(_ sender: Any) {
        openManual()
    }
    var product: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = product["Name"] as? String ?? ""
        shortDescText.text = product["ShortDescription"] as? String ?? ""
        fullDescText.text = product["FullDescription"] as? String ?? ""
        //adjustUITextViewHeight(arg: fullDescText)
        image1.image = product["IMG"] as? UIImage ?? #imageLiteral(resourceName: "product1")
        
        if (product["Manual"] as? String ?? "<null>") != "<null>" && Global.auth {
            if Global.userRole == 3 {
                self.button1.isHidden = false
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    func openManual() {
        print(Global.mediaLink + (product["Manual"] as? String ?? ""))
        UIApplication.shared.open(URL(string: Global.mediaLink + (product["Manual"] as? String ?? "")) ?? URL(string: "https://google.com")!, options: [:], completionHandler: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            return (product["ProductBulletFact"] as? [[String: Any]] ?? []).count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductBulletTableViewCell
        cell.label1.text = (product["ProductBulletFact"] as? [[String: Any]] ?? [])[indexPath.row]["Fact"] as? String ?? ""
        return cell
    }

}
