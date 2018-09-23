//
//  Extensions.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-13.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

extension String {
  
  func longStateName() -> String {
    
    guard self.count == 2 else { return self }
    
    let stateDictionary: [String : String] = [
      "AK" : "Alaska",
      "AL" : "Alabama",
      "AR" : "Arkansas",
      "AS" : "American Samoa",
      "AZ" : "Arizona",
      "CA" : "California",
      "CO" : "Colorado",
      //      "CT" : "Connecticut",
      "DC" : "District of Columbia",
      //      "DE" : "Delaware",
      "FL" : "Florida",
      "GA" : "Georgia",
      "GU" : "Guam",
      "HI" : "Hawaii",
      "IA" : "Iowa",
      "ID" : "Idaho",
      //      "IL" : "Illinois",
      //      "IN" : "Indiana",
      //      "KS" : "Kansas",
      "KY" : "Kentucky",
      //      "LA" : "Louisiana",
      //      "MA" : "Massachusetts",
      "MD" : "Maryland",
      "ME" : "Maine",
      "MI" : "Michigan",
      "MN" : "Minnesota",
      "MO" : "Missouri",
      //      "MS" : "Mississippi",
      "MT" : "Montana",
      "NC" : "North Carolina",
      "ND" : "North Dakota",
      "NE" : "Nebraska",
      //      "NH" : "New Hampshire",
      "NJ" : "New Jersey",
      "NM" : "New Mexico",
      "NV" : "Nevada",
      "NY" : "New York",
      "OH" : "Ohio",
      //      "OK" : "Oklahoma",
      "OR" : "Oregon",
      "PA" : "Pennsylvania",
      "PR" : "Puerto Rico",
      //      "RI" : "Rhode Island",
      "SC" : "South Carolina",
      "SD" : "South Dakota",
      "TN" : "Tennessee",
      "TX" : "Texas",
      "UT" : "Utah",
      "VA" : "Virginia",
      "VI" : "Virgin Islands",
      //      "VT" : "Vermont",
      "WA" : "Washington",
      //      "WI" : "Wisconsin",
      "WV" : "West Virginia",
      "WY" : "Wyoming"]
    
    // check that key is in the dictionary
    guard stateDictionary[self.uppercased()] != nil else { return self }
    
    // if it's in the dictionary, return the longStateName
    if let longStateName = stateDictionary[self.uppercased()] {
      return longStateName
    }
    
    return self
    
  }
}

extension Double {
  
  public static var random: Double {
    return Double(arc4random()) / 0xFFFFFFFF
  }
  
  public static func random(min: Double, max: Double) -> Double {
    return Double.random * (max - min) + min
  }
  
  func rounded(toPlaces places:Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
  
  var cleanValue: String {
    return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
  }
  
}

extension UIColor {
  convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }
  convenience init(rgb: Int) {
    self.init(
      red: (rgb >> 16) & 0xFF,
      green: (rgb >> 8) & 0xFF,
      blue: rgb & 0xFF
    )
  }
}

extension UISearchBar {
  var textField: UITextField? {
    return subviews.first?.subviews.first(where: { $0.isKind(of: UITextField.self) }) as? UITextField
  }
}





















