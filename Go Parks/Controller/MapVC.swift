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
import Alamofire
import SwiftyJSON

class MapVC: UIViewController, CLLocationManagerDelegate {
  
  @IBOutlet weak var favorite: UIButton!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var parkName: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var parkDescription: UITextView!
  @IBOutlet var gestureRecognizer: UIScreenEdgePanGestureRecognizer!
  @IBAction func backGesture(_ sender: Any) {
    dismissVC()
  }
  @IBOutlet weak var weatherIcon: UIImageView!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var weatherActivity: UIActivityIndicatorView!
  
  var data : ParksData?
  let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
  let API_KEY = "5f42b2e58ddbe20022e7fde8f06c0960"
  let weatherDataModel = WeatherDataModel()
  
  var goLat = Double()
  var goLong = Double()
  var sentUrl = String()
  var manager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    parkName.text = data?.name
    parkDescription.text = data?.description
    
    //    if (data?.isFavorite)! {
    //      favorite.setImage(UIImage(named: "heartGrey"), for: .normal)
    //    } else {
    //      favorite.setImage(UIImage(named: "heartGreen"), for: .normal)
    //    }
    
    //    stateName.text = ""
    //    let states = data?.states
    //    var statesString = String()
    weatherActivity.hidesWhenStopped = true
    //    mapView.layer.cornerRadius = 20
    //    mapView.layer.borderWidth = 1
    //    mapView.layer.borderColor = UIColor.lightGray.cgColor
    //    photoImageView.layer.cornerRadius = 20
    
    //    if states?.count == 1 {
    //      stateName.text? = states![0].longStateName()
    //    } else {
    //      for i in states! {
    //        statesString.append("\(i.longStateName()), ")
    //      }
    //      statesString.removeLast(2)
    //      stateName.text? = statesString
    //    }
    photoImageView.image = UIImage(named: (data?.name)!)
    
    guard let lat = data?.lat else { return }
    guard let long = data?.long else { return }
    
    goLat = Double(lat)!
    goLong = Double(long)!
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
    photoImageView.isUserInteractionEnabled = true
    photoImageView.addGestureRecognizer(tapGestureRecognizer)
    
    let params : [String : String] = ["lat" : lat, "lon" : long, "appid" : API_KEY]
    getWeatherData(url: WEATHER_URL, parametrs: params)
    getLocatin(forLatitude: goLat, forLongitude: goLong)
  }
  
  @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
    
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
    
    self.mapView.addAnnotation(pinObject)
  }
  
  @IBAction func infoButton(_ sender: Any) {
    sentUrl = (data?.url)!
    DispatchQueue.main.async {
    self.performSegue(withIdentifier: "openUrl", sender: Any?.self)
    }
  }
  
  @IBAction func directionsButton(_ sender: Any) {
    sentUrl = (data?.directionsUrl)!
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "openUrl", sender: Any?.self)
    }
  }
  
  func getWeatherData(url: String, parametrs: [String: String]) {
    weatherActivity.startAnimating()
    
    Alamofire.request(url, method: .get, parameters: parametrs).responseJSON {
      
      response in
      if response.result.isSuccess {
        print("Sucess")
        
        let weatherJSON : JSON = JSON(response.result.value!)
        self.updateWeatherData(json: weatherJSON)
        self.weatherActivity.stopAnimating()
      } else {
        print("Error \(String(describing: response.result.error))")
      }
    }
  }
  
  @IBAction func backButton(_ sender: Any) {
    dismissVC()
  }
  
  @IBAction func favoriteButton(_ sender: Any) {
    if (data?.isFavorite)! {
      
      favorite.setImage(UIImage(named: "heartGrey"), for: .normal)
    } else {
      
      favorite.setImage(UIImage(named: "heartGreen"), for: .normal)
    }
  }
  
  
  
  func updateWeatherData (json: JSON) {
    
    if let tempResults = json["main"]["temp"].double {
      weatherDataModel.temperatupre = Int(tempResults - 273.15)
      weatherDataModel.city = json["name"].stringValue
      weatherDataModel.condition = json["weather"][0]["id"].intValue
      weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
      updateUIwithWeatherData()
    } else {
    }
  }
  
  func updateUIwithWeatherData() {
    temperatureLabel.text = String(weatherDataModel.temperatupre) + "°C"
    weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
  }
  
  @IBAction func directionButton(_ sender: Any) {
    
    UIApplication.shared.open(URL(string: "http://maps.apple.com/maps?daddr=\(goLat),\(goLong)")!, options: [:], completionHandler: nil)
  }
  
  func dismissVC() {
    DispatchQueue.main.async{
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "openUrl" {
      let destinationVC = segue.destination as! WebViewVC
      destinationVC.receivedUrl = sentUrl
    }
  }
}

