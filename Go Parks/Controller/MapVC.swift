//
//  MapVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-13.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class MapVC: UIViewController, CLLocationManagerDelegate {
  
  @IBOutlet weak var favorite: UIButton!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var parkName: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var parkDescription: UITextView!
  @IBOutlet var gestureRecognizer: UIScreenEdgePanGestureRecognizer!
  @IBAction func backGesture(_ sender: UIScreenEdgePanGestureRecognizer) {
    dismissVC()
  }
  @IBOutlet weak var weatherIcon: UIImageView!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var weatherActivity: UIActivityIndicatorView!
  @IBOutlet weak var favoriteImage: UIImageView!
  @IBOutlet weak var weatherInfoButton: UIButton!
  @IBOutlet weak var descriptionButton: UIButton!
  
  var data : ParksData?
  let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
  let API_KEY = "5f42b2e58ddbe20022e7fde8f06c0960"
  let weatherDataModel = WeatherDataModel()
  let service = Service.instance
  
  var goLat = Double()
  var goLong = Double()
  var sentUrl = String()
  var manager = CLLocationManager()
  
  override func viewWillAppear(_ animated: Bool) {
    if (data?.isFavorite)! {
      favoriteImage.image = UIImage(named: "heartGreen")
    } else {
      favoriteImage.image = UIImage(named: "heartGrey")
    }
    
    parkName.text = data?.name
    parkDescription.text = data?.description
//    parkDescription.setContentOffset(CGPoint.zero, animated: false)
    weatherInfoButton.isEnabled = true
//    directionInfoBtn.isEnabled = true
    descriptionButton.isEnabled = false
  }
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    parkDescription.setContentOffset(CGPoint.zero, animated: false)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
 

    weatherActivity.hidesWhenStopped = true

    photoImageView.image = UIImage(named: (data?.name)!)
    
    
    guard let lat = data?.lat else { return }
    guard let long = data?.long else { return }
    
    goLat = Double(lat)!
    goLong = Double(long)!
        
    let params : [String : String] = ["lat" : lat, "lon" : long, "appid" : API_KEY]
    getWeatherData(url: WEATHER_URL, parametrs: params)
    getLocatin(forLatitude: goLat, forLongitude: goLong)
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
  

  @IBAction func weatherInfoBtnPressed(_ sender: Any) {
    
    parkDescription.text = data?.weatherInfo
    weatherInfoButton.isEnabled = false
//    directionInfoBtn.isEnabled = true
    descriptionButton.isEnabled = true
    
  }
  
  
  @IBAction func descriptionButtonPressed(_ sender: Any) {
    
    parkDescription.text = data?.description
    weatherInfoButton.isEnabled = true
//    directionInfoBtn.isEnabled = true
    descriptionButton.isEnabled = false
    
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
    print("Back Pressed")
  }
  
  @IBAction func favoriteButton(_ sender: Any) {
    
    addToFavorite()
    
  }
  
  func addToFavorite() {
    for i in 0..<service.parksArray.count {
      
      if service.parksArray[i].name == data?.name {
        
        if service.parksArray[i].isFavorite == false {
          service.parksArray[i].isFavorite = true
          favoriteImage.image = UIImage(named: "heartGreen")
          
        } else if service.parksArray[i].isFavorite == true {
          service.parksArray[i].isFavorite = false
          favoriteImage.image = UIImage(named: "heartGrey")
        }
        service.saveParks()
      }
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

