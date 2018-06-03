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
  let parksFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Parks.plist")
  
  func getListOfParks(){
    let decoder = JSONDecoder()
    let file = Bundle.main.url(forResource: "parks", withExtension: "json")
    
    do {
      
      let data = try Data(contentsOf: file!)
      let parks = try decoder.decode([ParksData].self, from: data)
      for park in parks {
        parksArray.append(park)
      }
      
    } catch {
      print("eerrro")
    }
  }
  
  func collectionItemsResize(screenWidth: CGFloat) -> (CGFloat,CGFloat) {
    
    var cellWidth = CGFloat()
    var cellHeight = CGFloat()
    
    //X = 375
    //iPad 5th Gen = 768 x 1024
    //AIR = 768 x 1024
    //PRO 9.7 = 768
    //PRO 10.5 = 834
    //PRO 12.9 = 1024
    
    // iPhone SE, 5s
    if screenWidth == 320 {
      cellWidth = 300
      cellHeight = 215
    }
    // iPhone 6, 7, 8
    if screenWidth == 375 {
      cellWidth = 350
      cellHeight = 215
    }
    //iPhone 6+, 7+, 8+
    if screenWidth == 414 {
      cellWidth = 390
      cellHeight = 215
    }
    //iPad, AIR, Pro 9.7
    if screenWidth == 768 {
      cellWidth = 746
      cellHeight = 460
    }
    //iPadPro 10.5
    if screenWidth == 834 {
      cellWidth = 812
      cellHeight = 460
    }
    //iPadPro 12
    if screenWidth == 1024 {
      cellWidth = 1002
      cellHeight = 460
    }
    return (cellWidth, cellHeight)
  }
  
  //Save User Currencies using PropertyListEncoder
  func saveParks() {
    
    let encoder = PropertyListEncoder()
    
    do {
      
      let data = try encoder.encode(parksArray)
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
    //                 "CT",
    "DC",
    //                 "DE",
    "FL",
    //                 "GA",
    "HI",
    //                 "IA",
    "ID",
    //                 "IL",
    //                 "IN",
    //                 "KS",
    "KY",
    //                 "LA",
    //                 "MA",
    //                 "MD",
    "ME",
    "MI",
    "MN",
    //                 "MO",
    //                 "MS",
    "MT",
    "NC",
    //                 "ND",
    //                 "NE",
    //                 "NH",
    //                 "NJ",
    "NM",
    "NV",
    "NY",
    "OH",
    //                 "OK",
    "OR",
    //                 "PA",
    //                 "RI",
    "SC",
    "SD",
    "TN",
    "TX",
    "UT",
    "VA",
    "VI",
    //                 "VT",
    "WA",
    //                 "WI",
    //                 "WV",
    "WY"]
  
}
