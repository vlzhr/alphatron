//
//  MapViewController.swift
//  alphatron
//
//  Created by Anna on 26.05.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var map1: MKMapView!
    
    var points:[[String: Any]] = []
    
    func loadLocations() {
        let link = Global.apiLink + "Locations"
        DispatchQueue.main.async {
            let task = URLSession.shared.dataTask(with: URL(string: link)!) { (data, response, error) in
                if let content = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        print(link)
                        print(json[0])
                        
                        DispatchQueue.main.async {
                            self.points = json as? [[String : Any]] ?? []
                            self.setMap()
                        }
                    }
                    catch {
                        print("err")
                    }
                }
            }
            task.resume()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setMap()
        loadLocations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMap() {
        var annotations:[MKAnnotation] = []
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(40, 40)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(50.7677, 37.5802)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        for point in points {
            let annotation = MKPointAnnotation()
            annotation.title = point["Name"] as? String ?? ""
            annotation.subtitle = point["Description"] as? String ?? ""
            annotation.coordinate = CLLocationCoordinate2DMake(50.7677, 37.5802)
            annotations.append(annotation)
            print(point)
        }
        
        map1.showAnnotations(annotations, animated: true)
        map1.setRegion(region, animated: true)
    }
    


}
