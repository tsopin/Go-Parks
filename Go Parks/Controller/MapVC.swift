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
  
  @IBOutlet weak private var favorite: UIButton!
  @IBOutlet weak private var mapView: MKMapView!
  @IBOutlet weak private var parkName: UILabel!
  @IBOutlet weak private var photoImageView: UIImageView!
  @IBOutlet weak private var parkDescription: UITextView!
  @IBOutlet weak private var weatherIcon: UIImageView!
  @IBOutlet weak private var favoriteBtn: UIButton!
  @IBOutlet weak private var temperatureLabel: UILabel!
  @IBOutlet weak private var changeUnitsBtn: UIButton!
  @IBOutlet weak private var weatherActivity: UIActivityIndicatorView!
  @IBOutlet weak private var weatherInfoButton: UIButton!
  @IBOutlet weak private var descriptionButton: UIButton!
  @IBOutlet weak private var unitsLabel: UILabel!
  @IBOutlet weak private var statesLabel: UILabel!
  @IBOutlet weak private var designationLabel: UILabel!
  
  //Constraints
  @IBOutlet weak private var descriptionViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak private var mapMinConstraint: NSLayoutConstraint!
  
  var data : ParksData?
  private let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
  private let API_KEY = "5f42b2e58ddbe20022e7fde8f06c0960"
  private let weatherDataModel = WeatherDataModel()
  private let service = Service.instance
  private let defaults = UserDefaults()
  private let screenSize : CGRect = UIScreen.main.bounds
  
  private var isCelsius = false
  private var goLat = Double()
  private var goLong = Double()
  private var sentUrl = String()
  private var manager = CLLocationManager()
  private var states = String()
  
  override func viewWillAppear(_ animated: Bool) {
    
    if (data?.isFavorite)! {
      favoriteBtn.setBackgroundImage(UIImage(named: "heartGreen"), for: .normal)
    } else {
      favoriteBtn.setBackgroundImage(UIImage(named: "heartGrey"), for: .normal)
    }
    
    statesLabel.text = states
    designationLabel.text = data?.designation
    photoImageView.image = UIImage(named: (data?.name)!)
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
    
    for state in (data?.states)! {
      states.append("\(state) ")
    }
    
    self.parkDescription.delegate = self
    parkDescription.textContainer.lineFragmentPadding = 0
    parkDescription.textContainerInset = .zero
    weatherActivity.hidesWhenStopped = true
    
    descriptionButton.setBackgroundImage(UIImage(named: "infoGrey"), for: .normal)
    isCelsius = defaults.bool(forKey: "isCelsius")
    parkDescription.dataDetectorTypes = .all
    
    guard let lat = data?.lat else { return }
    guard let long = data?.long else { return }
    
    goLat = Double(lat)!
    goLong = Double(long)!
    
    let params : [String : String] = ["lat" : lat, "lon" : long, "appid" : API_KEY]
    getWeatherData(url: WEATHER_URL, parametrs: params)
    getLocatin(forLatitude: goLat, forLongitude: goLong)
    ajustScreen()
  }
  
  private func ajustScreen() {
    if screenSize.width == 834  { // iPadPro 10.5
      iPadViewAdjust(name: 42, description: 20)
    } else if screenSize.width == 768 { // iPad 5th Gen, Air, PRO 9.7
      iPadViewAdjust(name: 36, description: 18)
    } else if screenSize.width == 1024 { //iPadPro 12.9
      iPadViewAdjust(name: 50, description: 24)
    } else if screenSize.width == 375 && screenSize.height == 812 { // iPhone X
      mapMinConstraint.constant = 170
      descriptionViewHeightConstraint.constant = -60
    } else if screenSize.width == 375 { // iPhone 6, 7, 8
      descriptionViewHeightConstraint.constant = 0
    }
  }
  
  private func iPadViewAdjust(name: CGFloat, description: CGFloat) {
    parkName.font = UIFont(name: "Ubuntu-Bold", size: name)
    parkDescription.font = UIFont(name: "OpenSans-Regular", size: description)
    designationLabel.font = UIFont(name: "OpenSans-Italic", size: description)
    mapMinConstraint.constant = screenSize.width * 0.29
    descriptionViewHeightConstraint.constant = screenSize.width * 0.28
  }
  
  private func getLocatin(forLatitude: Double, forLongitude: Double) {
    let span = MKCoordinateSpanMake(0.4, 0.4)
    let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: forLatitude, longitude: forLongitude), span: span)
    let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(forLatitude, forLongitude)
    let pinObject = MKPointAnnotation()
    
    mapView.setRegion(region, animated: true)
    pinObject.coordinate = pinLocation
    pinObject.title = data?.fullName
    self.mapView.addAnnotation(pinObject)
  }
  
  @IBAction private func infoButton(_ sender: Any) {
    sentUrl = (data?.url)!
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "openUrl", sender: Any?.self)
    }
  }
  
  @IBAction private func weatherInfoBtnPressed(_ sender: UIButton) {
    parkDescription.text = data?.weatherInfo
    weatherInfoButton.setBackgroundImage(UIImage(named: "cloudyGrey"), for: .normal)
    descriptionButton.setBackgroundImage(UIImage(named: "info"), for: .normal)
    weatherInfoButton.isEnabled = false
    descriptionButton.isEnabled = true
  }
  
  @IBAction private func  descriptionButtonPressed(_ sender: UIButton) {
    parkDescription.text = data?.description
    weatherInfoButton.isEnabled = true
    descriptionButton.setBackgroundImage(UIImage(named: "infoGrey"), for: .normal)
    weatherInfoButton.setBackgroundImage(UIImage(named: "cloudy"), for: .normal)
    descriptionButton.isEnabled = false
  }
  
  private func getWeatherData(url: String, parametrs: [String: String]) {
    weatherActivity.startAnimating()
    changeUnitsBtn.isEnabled = false
    
    Alamofire.request(url, method: .get, parameters: parametrs).responseJSON { response in
      
      if response.result.isSuccess {
        let weatherJSON : JSON = JSON(response.result.value!)
        self.updateWeatherData(json: weatherJSON)
        self.weatherActivity.stopAnimating()
        self.changeUnitsBtn.isEnabled = true
      } else {
        print("Error \(String(describing: response.result.error))")
      }
    }
  }
  
  @IBAction private func favoriteButton(_ sender: UIButton) {
    service.animateButton(sender)
    addToFavorite()
  }
  
  @IBAction private func changeTempUnits(_ sender: Any) {
    changeInits()
  }
  
  private func changeInits() {
    let k = Double(weatherDataModel.temperatupre)
    let f = Int( 1.8 * (k - 273) + 32)
    
    if (unitsLabel.text?.contains("C"))! {
      temperatureLabel.text = "\(f)"
      unitsLabel.text = "F"
      isCelsius = false
    } else if (unitsLabel.text?.contains("F"))! {
      temperatureLabel.text = String(weatherDataModel.temperatupre - 273)
      unitsLabel.text = "C"
      isCelsius = true
    }
    defaults.set(isCelsius, forKey: "isCelsius")
  }
  
  private func addToFavorite() {
    for i in 0..<service.parksArray.count {
      
      if service.parksArray[i].name == data?.name {
        
        if service.parksArray[i].isFavorite == false {
          service.parksArray[i].isFavorite = true
          favoriteBtn.setBackgroundImage(UIImage(named: "heartGreen"), for: .normal)
          
        } else if service.parksArray[i].isFavorite == true {
          service.parksArray[i].isFavorite = false
          favoriteBtn.setBackgroundImage(UIImage(named: "heartGrey"), for: .normal)
        }
        service.saveParks(isFirstRun: false)
      }
    }
  }
  
  private func updateWeatherData (json: JSON) {
    if let tempResults = json["main"]["temp"].double {
      weatherDataModel.temperatupre = Int(tempResults)
      weatherDataModel.city = json["name"].stringValue
      weatherDataModel.condition = json["weather"][0]["id"].intValue
      weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
      updateUIwithWeatherData()
    } else {
      print("JSON Error")
    }
  }
  
  private func updateUIwithWeatherData() {
    let k = Double(weatherDataModel.temperatupre)
    let f = Int( 1.8 * (k - 273) + 32 )
    
    if isCelsius {
      temperatureLabel.text = String(weatherDataModel.temperatupre - 273)
      unitsLabel.text = "C"
    } else {
      unitsLabel.text = "F"
      temperatureLabel.text = "\(f)"
    }
    weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
  }
  
  @IBAction private func directionButton(_ sender: Any) {
    UIApplication.shared.open(URL(string: "http://maps.apple.com/maps?daddr=\(goLat),\(goLong)")!, options: [:], completionHandler: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "openUrl" {
      let destinationVC = segue.destination as! WebViewVC
      destinationVC.receivedUrl = sentUrl
    }
  }
  
  func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    return true
  }
  
  deinit {}
}


