//
//  ProductsViewController.swift
//  alphatron
//
//  Created by Anna on 23.05.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {

    @IBOutlet weak var tb: UITableView!
    var searchController:UISearchController!
    
    
    var products = [["ProductBulletFact":["fact one", "fact two"],"ID":1,"Picture":"","Name":"RMD 541-43","ShortDescription":"Radar","FullDescription":"this is description"], ["ProductBulletFact":[],"ID":2,"Picture":"","Name":"A2000","ShortDescription":"Professional standart realibility","FullDescription":"this is description"]]
    
    var images: [UIImage] = []
    var imageExamples: [UIImage] = [#imageLiteral(resourceName: "product1"), #imageLiteral(resourceName: "product2")]
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, count: Int) {
        print("Download Started")
        print(url)
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.products[count]["IMG"] = UIImage(data: data)!
                self.images.append(UIImage(data: data)!)
                self.tb.reloadData()
                //self.imageView.image = UIImage(data: data)
            }
        }
    }
    
    var searchResults: [[String: Any]] = []
    func filterContent(for searchText: String) {
        searchResults = products.filter({ (product) -> Bool in
            var s = product["FullDescription"] as? String ?? ""
            s += product["ShortDescription"] as? String ?? ""
            s += product["Name"] as? String ?? ""
            let isMatch = s.localizedCaseInsensitiveContains(searchText)
            return isMatch
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            print("FILTERED")
            tb.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController = UISearchController(searchResultsController: nil)
        tb.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        
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
                            let count = self.products.index(where: { (item) -> Bool in
                                (item["ID"] as? Int ?? 0) == (product["ID"] as? Int ?? 0)
                            })
                            self.downloadImage(url: URL(string: Global.mediaLink + (product["Picture"] as? String ?? "https://www.w3schools.com/w3css/img_lights.jpg"))!, count: count!)
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
            if searchController.isActive {
                return searchResults.count
            } else {
                return products.count
            }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            print("alright")
            let cellIdentifier = "cell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductsTableViewCell
            let product = (searchController.isActive) ? searchResults[indexPath.row]
                : products[indexPath.row]
            cell.label1.text = product["Name"] as? String ?? ""
            cell.label2.text = product["ShortDescription"] as? String ?? ""
            if images.count > indexPath.row {
                cell.image1.image = product["IMG"] as? UIImage ?? #imageLiteral(resourceName: "product1")
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
        if searchController.isActive {
            nextView.product = searchResults[productIndex]
        } else {
            nextView.product = products[productIndex]
        }
    }
}

