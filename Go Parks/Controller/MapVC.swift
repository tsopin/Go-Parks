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

class MapVC: UIViewController, CLLocationManagerDelegate, UITextViewDelegate {
  
  @IBOutlet weak var favorite: UIButton!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var parkName: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var parkDescription: UITextView!
  @IBOutlet weak var weatherIcon: UIImageView!
  @IBOutlet weak var favoriteBtn: UIButton!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var weatherActivity: UIActivityIndicatorView!
  @IBOutlet weak var weatherInfoButton: UIButton!
  @IBOutlet weak var descriptionButton: UIButton!
  
  var data : ParksData?
  let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
  let API_KEY = "5f42b2e58ddbe20022e7fde8f06c0960"
  let weatherDataModel = WeatherDataModel()
  let service = Service.instance
  let defaults = UserDefaults()
  
  var isCelsius = false
  var goLat = Double()
  var goLong = Double()
  var sentUrl = String()
  var manager = CLLocationManager()
  
  override func viewWillAppear(_ animated: Bool) {
    
    if (data?.isFavorite)! {
      favoriteBtn.setBackgroundImage(UIImage(named: "heartGreen"), for: .normal)
    } else {
      favoriteBtn.setBackgroundImage(UIImage(named: "heartGrey"), for: .normal)
    }
    
    parkName.text = data?.name
    parkDescription.text = data?.description
    weatherInfoButton.isEnabled = true
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
    descriptionButton.setBackgroundImage(UIImage(named: "infoGrey"), for: .normal)
    isCelsius = defaults.bool(forKey: "isCelsius")

    
    self.parkDescription.delegate = self
    parkDescription.dataDetectorTypes = .all
    
    
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
  
  
  @IBAction func weatherInfoBtnPressed(_ sender: UIButton) {
    
    parkDescription.text = data?.weatherInfo
    weatherInfoButton.setBackgroundImage(UIImage(named: "cloudyGrey"), for: .normal)
    descriptionButton.setBackgroundImage(UIImage(named: "info"), for: .normal)
    weatherInfoButton.isEnabled = false
    descriptionButton.isEnabled = true
    
  }
  
  @IBAction func descriptionButtonPressed(_ sender: UIButton) {
    
    parkDescription.text = data?.description
    weatherInfoButton.isEnabled = true
    descriptionButton.setBackgroundImage(UIImage(named: "infoGrey"), for: .normal)
    weatherInfoButton.setBackgroundImage(UIImage(named: "cloudy"), for: .normal)
    descriptionButton.isEnabled = false
    
  }
  
  func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    return true
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
  
  @IBAction func favoriteButton(_ sender: UIButton) {
    
    service.animateButton(sender)
    addToFavorite()
    
  }
  
  @IBAction func changeTempUnits(_ sender: Any) {
    let k = Double(weatherDataModel.temperatupre)
    let f = Int( 1.8 * (k - 273) + 32 )
    
    print(f)
    
    if (temperatureLabel.text?.contains("°C"))! {
      temperatureLabel.text = "\(f)°F"
      isCelsius = false
    } else if (temperatureLabel.text?.contains("°F"))! {
      temperatureLabel.text = String(weatherDataModel.temperatupre - 273) + "°C"
      isCelsius = true
    }
    defaults.set(isCelsius, forKey: "isCelsius")
  }
  
  func addToFavorite() {
    for i in 0..<service.parksArray.count {
      
      if service.parksArray[i].name == data?.name {
        
        if service.parksArray[i].isFavorite == false {
          service.parksArray[i].isFavorite = true
          favoriteBtn.setBackgroundImage(UIImage(named: "heartGreen"), for: .normal)
          //          favoriteImage.image = UIImage(named: "heartGreen")
          
        } else if service.parksArray[i].isFavorite == true {
          service.parksArray[i].isFavorite = false
          favoriteBtn.setBackgroundImage(UIImage(named: "heartGrey"), for: .normal)
          //          favoriteImage.image = UIImage(named: "heartGrey")
        }
        service.saveParks()
      }
    }
  }
  
  
  func updateWeatherData (json: JSON) {
    
    if let tempResults = json["main"]["temp"].double {
      weatherDataModel.temperatupre = Int(tempResults)
      weatherDataModel.city = json["name"].stringValue
      weatherDataModel.condition = json["weather"][0]["id"].intValue
      weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
      updateUIwithWeatherData()
    } else {
    }
  }
  
  func updateUIwithWeatherData() {
    let k = Double(weatherDataModel.temperatupre)
    let f = Int( 1.8 * (k - 273) + 32 )
    
    if isCelsius {
    temperatureLabel.text = String(weatherDataModel.temperatupre - 273) + "°C"
    } else {
      temperatureLabel.text = "\(f)°F"
    }
    weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
  }
  
  @IBAction func directionButton(_ sender: Any) {
    
    UIApplication.shared.open(URL(string: "http://maps.apple.com/maps?daddr=\(goLat),\(goLong)")!, options: [:], completionHandler: nil)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "openUrl" {
      let destinationVC = segue.destination as! WebViewVC
      destinationVC.receivedUrl = sentUrl
    }
  }
}

