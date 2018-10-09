//
//  CampgroundData.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-08-20.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CampgroundData : Codable {
  
  var regulationsUrl : String?
  var weatherOverview : String?
  var campsites : Campsites?
  var accessibility : Accessibility?
  var directionsOverview : String?
  var reservationsUrl : String?
  var directionsUrl : String?
  var reservationsSitesFirstCome : String?
  var name : String?
  var regulationsOverview : String?
  var latLong : String?
  var description : String?
  var reservationsSitesReservable : String?
  var parkCode : String?
  var amenities : Amenities?
  var id : Int?
  var reservationsDescription : String?
  
  enum CodingKeys: String, CodingKey {
    
    case regulationsUrl = "regulationsUrl"
    case weatherOverview = "weatherOverview"
    case campsites = "campsites"
    case accessibility = "accessibility"
    case directionsOverview = "directionsOverview"
    case reservationsUrl = "reservationsUrl"
    case directionsUrl = "directionsUrl"
    case reservationsSitesFirstCome = "reservationsSitesFirstCome"
    case name = "name"
    case regulationsOverview = "regulationsOverview"
    case latLong = "latLong"
    case description = "description"
    case reservationsSitesReservable = "reservationsSitesReservable"
    case parkCode = "parkCode"
    case amenities = "amenities"
    case id = "id"
    case reservationsDescription = "reservationsDescription"
  }
  
  static func getCampgroundFrom(_ rawData: JSON) -> CampgroundData {
    
    var campground = CampgroundData()
    let campsites = rawData["campsites"].dictionaryValue
    let accessibility = rawData["accessibility"].dictionaryValue
    let amenities = rawData["amenities"].dictionaryValue
    
    campground.regulationsUrl = rawData["regulationsUrl"].stringValue
    campground.weatherOverview = rawData["weatherOverview"].stringValue
    campground.campsites = Campsites.getCampsitesFrom(campsites)
    campground.accessibility = Accessibility.getAccessibilityFrom(accessibility)
    campground.directionsOverview = rawData["directionsOverview"].stringValue
    campground.reservationsUrl = rawData["reservationsUrl"].stringValue
    campground.directionsUrl = rawData["directionsUrl"].stringValue
    campground.reservationsSitesFirstCome = rawData["reservationsSitesFirstCome"].stringValue
    campground.name = rawData["name"].stringValue
    campground.regulationsOverview = rawData["regulationsOverview"].stringValue
    campground.latLong = rawData["latLong"].stringValue
    campground.description = rawData["description"].stringValue
    campground.reservationsSitesReservable = rawData["reservationsSitesReservable"].stringValue
    campground.parkCode = rawData["reservationsSitesReservable"].stringValue
    campground.amenities = Amenities.getAmenitiesFrom(amenities)
    campground.id = rawData["id"].intValue
    campground.reservationsDescription = rawData["reservationsDescription"].stringValue
    
    print("mmm \(campground)")
    
    return campground
  }
}
