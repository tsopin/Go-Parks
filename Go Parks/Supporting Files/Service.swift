//
//  Service.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-14.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class Service {
  
  static let instance = Service()
  
  let defaults = UserDefaults()
  var parksArray = [ParksData]()
  var clearParks =  [ParksData]()
  let parksFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Parks.plist")
  
  func getListOfParks(isFirstRun: Bool) {
    
    let decoder = JSONDecoder()
    let file = Bundle.main.url(forResource: "parks", withExtension: "json")
    
    do {
      let data = try Data(contentsOf: file!)
      let parks = try decoder.decode([ParksData].self, from: data)
      for park in parks {
        if isFirstRun {
          clearParks.append(park)
        } else {
          parksArray.append(park)
        }
      }
      clearParks = clearParks.sorted { $0.name < $1.name }
      parksArray = parksArray.sorted { $0.name < $1.name }
    } catch {
      print("eerrro")
    }
  }
  
  func collectionItemsResize(screenWidth: CGFloat) -> (width: CGFloat, height: CGFloat) {
    var cellWidth = CGFloat()
    var cellHeight = CGFloat()
    
    cellWidth = screenWidth - screenWidth * 0.07
    cellHeight = cellWidth / 1.78
    
    return (width: cellWidth, height: cellHeight)
  }
  
  //Save User Currencies using PropertyListEncoder
  func saveParks(isFirstRun: Bool) {
    let encoder = PropertyListEncoder()
    
    do {
      var data = Data()
      if isFirstRun {
        data = try encoder.encode(clearParks)
      } else {
        data = try encoder.encode(parksArray)
      }
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
  
  //Checking if it is first run of app
  func isFirstRun() {
    
    let notFirstRun = defaults.bool(forKey: "notFirstRun")
    
    if notFirstRun {
      loadParks()
      print("Not first run, Load user's parks")
    } else {
      defaults.set(true, forKey: "notFirstRun")
      getListOfParks(isFirstRun: true)
      saveParks(isFirstRun: true)
      loadParks()
      print("First run, clear old data")
    }
  }
  
  func animateButton(_ sender: UIButton) {
    
    sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
    
    UIView.animate(withDuration: 0.70,
                   delay: 0,
                   usingSpringWithDamping: CGFloat(0.30),
                   initialSpringVelocity: CGFloat(6.0),
                   options: UIViewAnimationOptions.allowUserInteraction,
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






