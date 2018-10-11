//
//  ParkDetailsVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-13.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class ParkDetailsVC: UIViewController, CLLocationManagerDelegate, UITextViewDelegate, AlertCellDelegate {
  
  
  
  @IBOutlet weak private var weatherView: UIView!
  @IBOutlet weak private var closeAlertViewButton: UIButton!
  @IBOutlet weak private var campgroundsButton: UIButton!
  @IBOutlet weak private var alertsTableView: UITableView!
  @IBOutlet weak private var alertView: UIView!
  @IBOutlet weak private var alertButton: UIButton!
  @IBOutlet weak private var alertHeightConstraint: NSLayoutConstraint!
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
  @IBOutlet weak private var alertNotificationImage: UIImageView!
  @IBOutlet weak private var alertNotificationCount: UILabel!
  
  //Constraints
  @IBOutlet weak private var photoTopConstraint: NSLayoutConstraint!
  @IBOutlet weak private var alertViewConstraint: NSLayoutConstraint!
  @IBOutlet weak private var safeAreaBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak private var descriptionViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak private var mapMinConstraint: NSLayoutConstraint!
  
  var data : ParksData?
  var alertUrl : String?
  private let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
  private let API_KEY = "5f42b2e58ddbe20022e7fde8f06c0960"
  private let weatherData = WeatherData()
  private let service = Service.instance
  private let analytics = FirebaseAnalytics.instance
  private let defaults = UserDefaults()
  private let screenSize : CGRect = UIScreen.main.bounds
  private var alertsArray = [AlertData]()
  private var campgrounds: [CampgroundData]?
  
  
  private var isCelsius = false
  private var goLat = Double()
  private var goLong = Double()
  private var sentUrl = String()
  private var sentLabel = String()
  private var manager = CLLocationManager()
  private var states = String()
  private var device = String()
  
  override func viewWillAppear(_ animated: Bool) {
    getCampgroundData()
    self.campgroundsButton.isHidden = true
    
    if service.getDevice() == "X" || service.getDevice() == "XS Max" {
      safeAreaBottomConstraint.constant = 70
    } else {
      safeAreaBottomConstraint.constant = 0
    }
    
    self.alertNotificationImage.isHidden = true
    self.alertNotificationCount.isHidden = true
    self.alertButton.isHidden = true
    
    self.alertsTableView.delegate = self
    self.alertsTableView.dataSource = self
    
    if (data?.isFavorite)! {
      favoriteBtn.setBackgroundImage(UIImage(named: "heartGreen"), for: .normal)
    } else {
      favoriteBtn.setBackgroundImage(UIImage(named: "heartGrey"), for: .normal)
    }
    
    DispatchQueue.main.async {
      
      self.service.getAlerts(for: (self.data?.parkCode)!) { returnedAlerts in
        
        self.alertsArray = returnedAlerts
        
        if self.alertsArray.count == 0 {
          self.alertNotificationImage.isHidden = true
          self.alertNotificationCount.isHidden = true
          self.alertButton.isHidden = true
        } else {
          self.alertNotificationImage.isHidden = false
          self.alertNotificationCount.isHidden = false
          self.alertButton.isHidden = false
          self.alertNotificationCount.text = "\(self.alertsArray.count)"
          self.alertsTableView.reloadData()
        }
      }
    }
    
    statesLabel.text = states
    designationLabel.text = data?.designation
    photoImageView.image = UIImage(named: (data?.name)!)
    parkName.text = data?.name
    parkDescription.text = data?.description
    weatherInfoButton.isEnabled = true
    descriptionButton.isEnabled = false
    weatherView.isHidden = true
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
    
    alertsTableView.estimatedRowHeight = 130
    alertsTableView.rowHeight = UITableView.automaticDimension
    
    self.closeAlertViewButton.layer.shadowColor = UIColor.lightGray.cgColor
    self.closeAlertViewButton.layer.shadowOpacity = 1
    self.closeAlertViewButton.layer.shadowOffset = CGSize(width: 1, height: 1)
    self.closeAlertViewButton.layer.shadowRadius = 1
    
    guard let lat = data?.lat else { return }
    guard let long = data?.long else { return }
    
    goLat = Double(lat)!
    goLong = Double(long)!
    
    let params : [String : String] = ["lat" : lat, "lon" : long, "appid" : API_KEY]
    getWeatherData(url: WEATHER_URL, parametrs: params)
    getLocation (forLatitude: goLat, forLongitude: goLong)
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
      //      mapMinConstraint.constant = 170
      //      descriptionViewHeightConstraint.constant = -60
    } else if screenSize.width == 375 { // iPhone 6, 7, 8
      //      descriptionViewHeightConstraint.constant = 0
    }
  }
  
  private func iPadViewAdjust(name: CGFloat, description: CGFloat) {
    parkName.font = UIFont(name: "Ubuntu-Bold", size: name)
    parkDescription.font = UIFont(name: "OpenSans-Regular", size: description)
    designationLabel.font = UIFont(name: "OpenSans-Italic", size: description)
    //    mapMinConstraint.constant = screenSize.width * 0.29
    //    descriptionViewHeightConstraint.constant = screenSize.width * 0.28
  }
  
  private func getLocation (forLatitude: Double, forLongitude: Double) {
    let span = MKCoordinateSpan.init(latitudeDelta: 0.4, longitudeDelta: 0.4)
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
    sentLabel = (data?.name)!
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "openUrl", sender: Any?.self)
    }
    analytics.logWebView(park: (data?.name)!)
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
  
  @IBAction private func alertButtonPressed(_ sender: Any) {
    analytics.alertsOpen(park: (data?.name)!)
    
    if alertViewConstraint.constant < 0 {
      
      showAlertView()
    } else {
      hideAlertView()
      
    }
  }
  
  @IBAction private func hideAlertViewButtonPressed(_ sender: UIButton) {
    hideAlertView()
  }
  
  
  @IBAction private func campgroundButtonPressed(_ sender: Any) {
    getCampgroundData()
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "campgroundInfo", sender: Any?.self)
    }
  }
  
  func getCampgroundData() {
    service.getCampgrounds(for: (data?.parkCode)!) { (campground) in
      if campground.success {
        DispatchQueue.main.async {
          self.campgroundsButton.isHidden = false
        }
        self.campgrounds = campground.data
      }
    }
  }
  
  private func showAlertView() {
    print("Show \(alertsArray.count)")
    self.view.addSubview(alertView)
    
    self.alertsTableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
    
    alertHeightConstraint.constant = screenSize.height 
    alertViewConstraint.constant = 0
    
    UIView.animate(withDuration: 0.4) {
      self.navigationController?.isNavigationBarHidden = true
      self.view.layoutIfNeeded()
    }
    DispatchQueue.main.async {
      self.alertsTableView.reloadData()
    }
    
  }
  
  private func hideAlertView() {
    print("Hide")
    alertViewConstraint.constant = -(screenSize.height + 64)
    
    UIView.animate(withDuration: 0.4) {
      self.navigationController?.isNavigationBarHidden = false
      self.view.layoutIfNeeded()
      
    }
    
  }
  
  func openAlertUrl(cell: AlertCell) {
    
    guard let index = alertsTableView.indexPath(for: cell)?.row else {
      return
    }
    sentUrl = alertsArray[index].url!
    sentLabel = alertsArray[index].title!
    print("SENT URL \(sentUrl)")
    
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "openUrl", sender: Any?.self)
    }
    
  }
  
  
  private func getWeatherData(url: String, parametrs: [String: String]) {
    weatherActivity.startAnimating()
    changeUnitsBtn.isEnabled = false
    
    Alamofire.request(url, method: .get, parameters: parametrs).responseJSON { response in
      
      if response.result.isSuccess {
        let weatherJSON : JSON = JSON(response.result.value!)
        self.parseWeatherWith(json: weatherJSON)
        self.weatherActivity.stopAnimating()
        self.changeUnitsBtn.isEnabled = true
        self.weatherView.isHidden = false
      } else {
        print("Error \(String(describing: response.result.error))")
      }
    }
  }
  
  @IBAction private func favoriteButton(_ sender: UIButton) {
    service.animateButton(sender) { (success) in
    }
    self.addToFavorite()
  }
  
  @IBAction private func changeTempUnits(_ sender: Any) {
    changeInits()
    service.impact.impactOccurred()
  }
  
  private func changeInits() {
    let k = Double(weatherData.temperatupre)
    let f = Int( 1.8 * (k - 273) + 32)
    
    if (unitsLabel.text?.contains("C"))! {
      temperatureLabel.text = "\(f)"
      unitsLabel.text = "F"
      isCelsius = false
    } else if (unitsLabel.text?.contains("F"))! {
      temperatureLabel.text = String(weatherData.temperatupre - 273)
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
          self.analytics.addedToFavorite(park: "\(data?.name ?? "err")", screen: "Park Details")
          
        } else if service.parksArray[i].isFavorite == true {
          service.parksArray[i].isFavorite = false
          favoriteBtn.setBackgroundImage(UIImage(named: "heartGrey"), for: .normal)
        }
        service.saveData()
      }
    }
  }
  
  private func parseWeatherWith(json: JSON) {
    if let tempResults = json["main"]["temp"].double {
      weatherData.temperatupre = Int(tempResults)
      weatherData.condition = json["weather"][0]["id"].intValue
      weatherData.weatherIconName = weatherData.updateWeatherIcon(condition: weatherData.condition)
      updateUIwithWeatherData()
    } else {
      print("JSON Error")
    }
  }
  
  private func updateUIwithWeatherData() {
    let k = Double(weatherData.temperatupre)
    let f = Int( 1.8 * (k - 273) + 32 )
    
    if isCelsius {
      temperatureLabel.text = String(weatherData.temperatupre - 273)
      unitsLabel.text = "C"
    } else {
      unitsLabel.text = "F"
      temperatureLabel.text = "\(f)"
    }
    weatherIcon.image = UIImage(named: weatherData.weatherIconName)
  }
  
  @IBAction private func directionButton(_ sender: Any) {
    
    //    let googleUrl = URL(string: "comgooglemaps://?saddr=&daddr=\(goLat),\(goLong)&directionsmode=driving")
    let appleUrl = URL(string: "http://maps.apple.com/maps?daddr=\(goLat),\(goLong)")
    
    UIApplication.shared.open(appleUrl!, options: [:])
    analytics.directions(park: (data?.name)!)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "openUrl" {
      let destinationVC = segue.destination as! WebViewVC
      destinationVC.receivedUrl = sentUrl
      destinationVC.label = sentLabel
    } else if segue.identifier == "campgroundInfo" {
      let destinationVC = segue.destination as! CampgroundsVC
      destinationVC.recievedPark = data?.fullName
      destinationVC.data = campgrounds
    }
  }
  
  func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    return true
  }
  
  //  deinit {}
}
extension ParkDetailsVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return alertsArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = alertsTableView.dequeueReusableCell(withIdentifier: AlertCell.ID, for: indexPath) as! AlertCell
    cell.delegate = self
    
    if alertsArray.count > 0 {
      let alert = alertsArray[indexPath.row]
      print("\(alert.url!)")
      cell.configureCell(category: alert.category!, title: alert.title!, description: alert.description!, url: alert.url)
      return cell
    } else {
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}













