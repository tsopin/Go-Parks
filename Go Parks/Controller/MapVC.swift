//
//  MapVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-13.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit
import MapKit
import SimpleImageViewer

protocol ReceivePark {
  func parkReceived(data: ParksData)
}

class MapVC: UIViewController, CLLocationManagerDelegate {
  
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var parkName: UILabel!
  @IBOutlet weak var stateName: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var parkDescription: UITextView!
  @IBOutlet var gestureRecognizer: UIScreenEdgePanGestureRecognizer!
  

  @IBAction func backGesture(_ sender: Any) {
    
    dismiss(animated: true, completion: nil)
  }
  
  var delegate : ReceivePark?
  var data : ParksData?
  
  var manager = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()
      parkName.text = data?.fullName
      parkDescription.text = data?.description
      stateName.text = data?.states.longStateName()
      photoImageView.image = UIImage(named: (data?.name)!)
      
      guard let lat = data?.lat else { return }
      guard let long = data?.long else { return }
      
      let goLat = Double(lat)
      let goLong = Double(long)
      
      let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
      photoImageView.isUserInteractionEnabled = true
      photoImageView.addGestureRecognizer(tapGestureRecognizer)

      
      
      getLocatin(forLatitude: goLat!, forLongitude: goLong!)

        // Do any additional setup after loading the view.
    }
  @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
    
//    let tappedImage = tapGestureRecognizer.view as! UIImageView
    
    let configuration = ImageViewerConfiguration { config in
      config.imageView = photoImageView
    }
    present(ImageViewerController(configuration: configuration), animated: true)
  }
  
  func getLocatin(forLatitude: Double, forLongitude: Double) {
    let span = MKCoordinateSpanMake(0.4, 0.4)
    let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: forLatitude, longitude: forLongitude), span: span)
    
    mapView.setRegion(region, animated: true)
    
    let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(forLatitude, forLongitude)
    let pinObject = MKPointAnnotation()
    
    pinObject.coordinate = pinLocation
        pinObject.title = data?.fullName
//        pinObject.subtitle = "This Location"
    
    self.mapView.addAnnotation(pinObject)
  }
  @IBAction func infoButton(_ sender: Any) {
    
    UIApplication.shared.open(URL(string: (data?.url)!)!, options: [:], completionHandler: nil)
    
  }
  
  @IBAction func directionsButton(_ sender: Any) {
    UIApplication.shared.open(URL(string: (data?.directionsUrl)!)!, options: [:], completionHandler: nil)
  }
}

