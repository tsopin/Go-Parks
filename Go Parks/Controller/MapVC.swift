//
//  MapVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-13.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit
import MapKit

protocol ReceivePark {
  func parkReceived(data: ParksData)
}

class MapVC: UIViewController, CLLocationManagerDelegate {
  
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var parkName: UILabel!
  @IBOutlet weak var stateName: UILabel!
  @IBOutlet weak var parkDescription: UITextView!
  
//  let parkName = data?.fullName
//  let parkDecsription = data?.description
//  let parkStates = data?.states
//  let parkLat = data?.lat
  
  var delegate : ReceivePark?
  var data : ParksData?
  
  var manager = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()
      parkName.text = data?.fullName
      parkDescription.text = data?.description
      stateName.text = data?.states.longStateName()
      
      guard let lat = data?.lat else { return }
      guard let long = data?.long else { return }
      
      let goLat = Double(lat)
      let goLong = Double(long)
     
      
      
      
      getLocatin(forLatitude: goLat!, forLongitude: goLong!)

        // Do any additional setup after loading the view.
    }

  
  func getLocatin(forLatitude: Double, forLongitude: Double) {
    let span = MKCoordinateSpanMake(0.3, 0.3)
    let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: forLatitude, longitude: forLongitude), span: span)
    
    mapView.setRegion(region, animated: true)
    
    let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(forLatitude, forLongitude)
    let pinObject = MKPointAnnotation()
    
    pinObject.coordinate = pinLocation
        pinObject.title = data?.fullName
        pinObject.subtitle = "This Location"
    
    self.mapView.addAnnotation(pinObject)
  }
  @IBAction func infoButton(_ sender: Any) {
    
    UIApplication.shared.open(URL(string: (data?.url)!)!, options: [:], completionHandler: nil)
    
  }
  
  @IBAction func directionsButton(_ sender: Any) {
    UIApplication.shared.open(URL(string: (data?.directionsUrl)!)!, options: [:], completionHandler: nil)
  }
}

