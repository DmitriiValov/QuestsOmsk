//
//  MapViewController.swift
//  Quests
//
//  Created by Dmitry Valov on 01/04/2017.
//  Copyright © 2017 Dmitry Valov. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

  var company: Company!
  
  @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      mapView.delegate = self
      
      let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("Омск " + company.address) { (placemarks, error) in
        
        guard error == nil else { return }
        guard let placemarks = placemarks else { return }
        
        let placemark = placemarks.first!
        
        let annotation = MKPointAnnotation()
        annotation.title = self.company.name
        annotation.subtitle = self.company.address
        
        guard let location = placemark.location else { return }
        annotation.coordinate = location.coordinate
        
        self.mapView.showAnnotations([annotation], animated: true)
        self.mapView.selectAnnotation(annotation, animated: true)
        
      }

        // Do any additional setup after loading the view.
    }

  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard !(annotation is MKUserLocation) else { return nil }
    
    let annotaionIdentifier = "restAnnotation"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotaionIdentifier) as? MKPinAnnotationView
    
    if annotationView == nil {
      annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotaionIdentifier)
      annotationView?.canShowCallout = true
    }
    
    let rightImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    rightImage.image = UIImage(named:company.icon)
    annotationView?.rightCalloutAccessoryView = rightImage
    
    annotationView?.pinTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    return annotationView
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
