//
//  MapViewController.swift
//  alphatron
//
//  Created by Anna on 26.05.18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map1: MKMapView!
    
    var points:[[String: Any]] = []
    var annotations:[MKAnnotation] = []
    var annotationsData: [[String]] = []
    
    func loadLocations() {
        let link = Global.apiLink + "Locations"
        DispatchQueue.main.async {
            let task = URLSession.shared.dataTask(with: URL(string: link)!) { (data, response, error) in
                if let content = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        //print(link)
                        print(json)
                        //print(json[0])
                        
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) ->
        MKAnnotationView? {
            let identifier = "MyPin"
            if annotation.isKind(of: MKUserLocation.self) {
                return nil
            }
            // Reuse the annotation if possible
            var annotationView:MKPinAnnotationView? =
                mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as?
            MKPinAnnotationView
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation,
                                                     reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            }
            
            let index = annotations.index(where: { (item) -> Bool in
                (item.title as? String ?? "") == (annotation.title as? String ?? "a")
            })
            let mail: String = (annotationsData[index!])[0]
            let phone: String = (annotationsData[index!])[1]
            
            let leftView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
            leftView.image = #imageLiteral(resourceName: "icons8-company-50")

            let rightView = UIView(frame: CGRect.init(x: 0, y: 0, width: 71, height: 20))
            let emailLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: 110, height: 11))
            let phoneLabel = UILabel(frame: CGRect.init(x: 0, y: 11, width: 110, height: 9))
            emailLabel.textAlignment = .right
            emailLabel.font = emailLabel.font.withSize(11)
            emailLabel.adjustsFontSizeToFitWidth = true
            phoneLabel.textAlignment = .right
            phoneLabel.font = phoneLabel.font.withSize(9)
            phoneLabel.adjustsFontSizeToFitWidth = true
            //phoneLabel.textColor
            rightView.addSubview(emailLabel)
            rightView.addSubview(phoneLabel)
            emailLabel.text = mail
            phoneLabel.text = phone
            annotationView?.rightCalloutAccessoryView = rightView
            annotationView?.leftCalloutAccessoryView = leftView
            

            return annotationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map1.delegate = self
        
        //setMap()
        loadLocations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMap() {
        
        for point in points {
            let annotation = MKPointAnnotation()
            annotation.title = point["Name"] as? String ?? ""
            let desc = point["Description"] as? String ?? ""
            let email = point["Email"] as? String ?? "mail"
            let phone = point["PhoneNumber"] as? String ?? "phone"
            annotation.subtitle = desc
            print(Double(point["Latitude"] as? String ?? "0")!, Double(point["Longtitude"] as? String ?? "0")!)
            annotation.coordinate = CLLocationCoordinate2DMake(Double(point["Latitude"] as? String ?? "0")!, Double(point["Longtitude"] as? String ?? "0")!)
            annotationsData.append([email, phone])
            annotations.append(annotation)
        }
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(70, 70)
        let location:CLLocationCoordinate2D = annotations[0].coordinate
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map1.setRegion(region, animated: false)
        map1.showAnnotations(annotations, animated: true)
    }
    


}
