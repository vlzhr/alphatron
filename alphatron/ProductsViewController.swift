//
//  ProductsViewController.swift
//  alphatron
//
//  Created by Anna on 23.05.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tb: UITableView!
    
    
    
    
    var products = [["ProductBulletFact":["fact one", "fact two"],"ID":1,"Picture":"","Name":"RMD 541-43","ShortDescription":"Radar","FullDescription":"this is description"], ["ProductBulletFact":[],"ID":2,"Picture":"","Name":"A2000","ShortDescription":"Professional standart realibility","FullDescription":"this is description"]]
    
    var images: [UIImage] = []
    var imageExamples: [UIImage] = [#imageLiteral(resourceName: "product1"), #imageLiteral(resourceName: "product2")]
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        print(url)
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.products[self.images.count]["IMG"] = UIImage(data: data)!
                self.images.append(UIImage(data: data)!)
                self.tb.reloadData()
                //self.imageView.image = UIImage(data: data)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let link = Global.apiLink + "Products"
        
        DispatchQueue.main.async {
            let task = URLSession.shared.dataTask(with: URL(string: link)!) { (data, response, error) in
                if let content = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        print(link)
                        print(json)
                        
                        self.products = json as? [[String: Any]] ?? []
                        for product in self.products {
                            self.downloadImage(url: URL(string: Global.mediaLink + (product["Picture"] as? String ?? "https://www.w3schools.com/w3css/img_lights.jpg"))!)
                        }
                        
                        DispatchQueue.main.async {
                            self.tb.reloadData()
                        }
                    }
                    catch {
                        print("err")
                    }
                }
            }
            
            task.resume()
        }
        
        //print("Begin of code")
        //if let url = URL(string: "https://www.w3schools.com/w3css/img_lights.jpg") {
            //downloadImage(url: url)
        //}
        //print("End of code. The image will continue downloading in the background and it will be loaded when it ends.")

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
            cell.label1.text = products[indexPath.row]["Name"] as? String ?? ""
            cell.label2.text = products[indexPath.row]["ShortDescription"] as? String ?? ""
            if images.count > indexPath.row {
                cell.image1.image = images[indexPath.row]
            } else {
                cell.image1.image = imageExamples[0]
            }
            
            return cell
        }
    
    var productIndex = 0
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath:
        IndexPath) {
        productIndex = indexPath.row
        performSegue(withIdentifier: "toProduct", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView = segue.destination as! ProductViewController
        nextView.product = products[productIndex]
    }
}

