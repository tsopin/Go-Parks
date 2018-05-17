//
//  Weather.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-17.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class WeatherDataModel {
  
  var temperatupre : Int = 0
  var condition : Int = 0
  var city : String = ""
  var weatherIconName : String = ""
  
  func updateWeatherIcon(condition: Int) -> String {
    
    switch (condition) {
      
    case 0...300 :
      return "thunderstorm"
      
    case 301...500 :
      return "lightRain"
      
    case 501...600 :
      return "showers"
      
    case 601...700 :
      return "lightSnow"
      
    case 701...771 :
      return "fog"
      
    case 772...799 :
      return "thunderstorm"
      
    case 800 :
      return "sunny"
      
    case 801...804 :
      return "fewClouds"
      
    case 900...903, 905...1000  :
      return "thunderstorm"
      
    case 903 :
      return "snow"
      
    case 904 :
      return "sunny"
      
    default :
      return "dunno"
      
    }
  }
}

