//
//  ProductsViewController.swift
//  alphatron
//
//  Created by Anna on 23.05.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var products = [["RMD 541-23", "Radar"], ["A2000", "Professional standart realibility"]]
    var imageExamples = [#imageLiteral(resourceName: "product1"), #imageLiteral(resourceName: "product2")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("alright 0")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            return products.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            print("alright")
            let cellIdentifier = "cell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductsTableViewCell
            cell.label1.text = products[indexPath.row][0]
            cell.label2.text = products[indexPath.row][1]
            cell.image1.image = imageExamples[indexPath.row]
            return cell
        }
    
    var toEdit = ["example1", "example2"]
    var productIndex = 0
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath:
        IndexPath) {
        productIndex = indexPath.row
        performSegue(withIdentifier: "toProduct", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let nextView = segue.destination as! EditingViewController
        //nextView.toEdit = toEdit
    }
}

