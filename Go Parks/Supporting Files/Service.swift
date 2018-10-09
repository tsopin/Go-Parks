//
//  Service.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-14.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit
import SwiftyJSON

class Service {
  
  func getDevice() -> String {
    var device = String()
    switch (Double(screenSize.width), Double(screenSize.height)) {
    case (320, 568):
      device = "SE"
    case (375, 667):
      device = "8"
    case (414, 736):
      device = "8P"
    case (375, 812):
      device = "X"
    case (414, 896):
      device = "XS Max"
    case (768, 1024):
      device = "Air"
    case (834, 1112):
      device = "Pro10"
    case (1024, 1366):
      device = "Pro12"
    default:
      break
    }
    return device
  }
  
  static let instance = Service()
  let screenSize : CGRect = UIScreen.main.bounds
  
  let defaults = UserDefaults()
  let parksFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Parks.plist")
  var parksArray = [ParksData]()
  var alertsArray = [AlertData]()
  var campgroundsArray = [CampgroundData]()
  
  private let API_KEY = "nRMNVDjegzk22LYILxiB2vN4ddayxQqJUkWMGQcU"
  
  func getListOfParks() {
    
    let decoder = JSONDecoder()
    let file = Bundle.main.url(forResource: "parks", withExtension: "json")
    
    do {
      let data = try Data(contentsOf: file!)
      let parks = try decoder.decode([ParksData].self, from: data)
      
      for park in parks {
        parksArray.append(park)
      }
      
      parksArray = parksArray.sorted { $0.name < $1.name }
    } catch {
      print("eerrro")
    }
  }
  
  func getAlerts(for park: String, handler: @escaping (_ returnedAlerts: [AlertData]) -> ()) {
    
    guard let API_URL = URL(string: "https://api.nps.gov/api/v1/alerts?parkCode=&parkCode=\(park)&limit=100&api_key=\(API_KEY)")  else { return }
    
    URLSession.shared.dataTask(with: API_URL) { (data, urlResponse, error) in
      
      DispatchQueue.main.async {
        
        guard let dataToDecode = data, error == nil, urlResponse != nil else {return}
        
        do {
          let decoder = JSONDecoder()
          
          let alerts = try decoder.decode(GetAlertData.self, from: dataToDecode)
          self.alertsArray.removeAll()
          
          for i in alerts.data! {
            self.alertsArray.append(i)
          }
          handler(self.alertsArray)
          
        } catch {
          print("eerrro")
        }
      }
      }.resume()
  }
  
  func getCampgrounds(for park: String, handler: @escaping (_ returnedCampgrounds: (data: [CampgroundData], success: Bool)) -> ()) {
    guard let API_URL = URL(string: "https://api.nps.gov/api/v1/campgrounds?parkCode=&parkCode=\(park)&limit=100&api_key=\(API_KEY)")  else { return }
    
    print("\(API_URL)")
    
    URLSession.shared.dataTask(with: API_URL) { (data, urlResponse, error) in
      
      let json = JSON(data as Any)
//      var campgroundsArray = [CampgroundData]()
      

      let jsonArray = json["data"].arrayValue
      self.campgroundsArray = jsonArray.map({ CampgroundData.getCampgroundFrom($0)})
      
//      for _ in jsonArray {
//
//        campgroundsArray.append(campground)
//      }
//      print("CAAAAM \(jsonArray)")
//      for i in jsonArray {
//
//      }
      
      
//      let adItems = jsonArray.map({ CampgroundData.getCampgroundFrom($0) })
      
      
      
      
      //      DispatchQueue.main.async {
      //
      //        guard let dataToDecode = data, error == nil, urlResponse != nil else {return}
      //
      //        do {
      //
      //          let decoder = JSONDecoder()
      //
      //          let campgrounds = try decoder.decode(GetCampgroundData.self, from: dataToDecode)
      //          self.campgroundsArray.removeAll()
      //
      //          for i in campgrounds.data! {
      //            self.campgroundsArray.append(i)
      //          }
      //
      //          if campgrounds.data!.count > 0 {
      //            print("Camp Success")
                  handler((self.campgroundsArray, true))
      //          } else {
      //            print("Camp Zero")
      //            handler((self.campgroundsArray, false))
      //          }
      //
      //        } catch {
      //          handler((self.campgroundsArray, false))
      //          print("Camp Error")
      //        }
      //      }
      }.resume()
  }
  
  func collectionItemsResize(screenWidth: CGFloat) -> (width: CGFloat, height: CGFloat) {
    var cellWidth = CGFloat()
    var cellHeight = CGFloat()
    
    cellWidth = screenWidth - screenWidth * 0.07
    cellHeight = cellWidth / 1.78
    
    return (width: cellWidth, height: cellHeight)
  }
  
  //Save User Currencies using PropertyListEncoder
  func saveParks() {
    let encoder = PropertyListEncoder()
    
    do {
      var data = Data()
      data = try encoder.encode(parksArray)
      try data.write(to: parksFilePath!)
    } catch {
      print("error \(error)")
    }
  }
  
  func loadParks() {
    if let data = try? Data(contentsOf: parksFilePath!) {
      let decoder = PropertyListDecoder()
      do {
        parksArray = try decoder.decode([ParksData].self, from: data)
      } catch {
        print("Error \(error)")
      }
    }
  }
  
  //Check whether it’s the first time running the app
  func isFirstRun() {
    
    let notFirstRun = defaults.bool(forKey: "notFirstRun")
    
    if notFirstRun {
      loadParks()
      print("Not first run, Load user's parks")
    } else {
      defaults.set(true, forKey: "notFirstRun")
      getListOfParks()
      saveParks()
      print("First run, clear old data")
    }
  }
  
  func animateButton(_ sender: UIButton) {
    
    sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
    
    UIView.animate(withDuration: 0.70,
                   delay: 0,
                   usingSpringWithDamping: CGFloat(0.30),
                   initialSpringVelocity: CGFloat(6.0),
                   options: UIView.AnimationOptions.allowUserInteraction,
                   animations: { sender.transform = CGAffineTransform.identity}, completion: { Void in() })
  }
  
  let stateNamesArray = [
    "AK",
    "AR",
    "AZ",
    "CA",
    "CO",
    //        "CT",
    "DC",
    //        "DE",
    "FL",
    "GA",
    "HI",
    "IA",
    "ID",
    //        "IL",
    //        "IN",
    //        "KS",
    "KY",
    //        "LA",
    //        "MA",
    "MD",
    "ME",
    "MI",
    "MN",
    "MO",
    //    "MS",
    "MT",
    "NC",
    "ND",
    "NE",
    //        "NH",
    //    "NJ",
    "NM",
    "NV",
    "NY",
    "OH",
    //        "OK",
    "OR",
    "PA",
    //        "RI",
    "SC",
    "SD",
    "TN",
    "TX",
    "UT",
    "VA",
    "VI",
    //        "VT",
    "WA",
    //        "WI",
    "WV",
    "WY"]
  
  
  
}



