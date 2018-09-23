//
//  CampgroundData.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-08-20.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import Foundation

struct CampgroundData : Codable {
  
  let regulationsUrl : String?
  let weatherOverview : String?
  let campsites : Campsites?
  let accessibility : Accessibility?
  let directionsOverview : String?
  let reservationsUrl : String?
  let directionsUrl : String?
  let reservationsSitesFirstCome : String?
  let name : String?
  let regulationsOverview : String?
  let latLong : String?
  let description : String?
  let reservationsSitesReservable : String?
  let parkCode : String?
  let amenities : Amenities?
  let id : Int?
  let reservationsDescription : String?

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

//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//    regulationsUrl = try values.decodeIfPresent(String.self, forKey: .regulationsUrl)
//    weatherOverview = try values.decodeIfPresent(String.self, forKey: .weatherOverview)
//    campsites = try values.decodeIfPresent(Campsites.self, forKey: .campsites)
//    accessibility = try values.decodeIfPresent(Accessibility.self, forKey: .accessibility)
//    directionsOverview = try values.decodeIfPresent(String.self, forKey: .directionsOverview)
//    reservationsUrl = try values.decodeIfPresent(String.self, forKey: .reservationsUrl)
//    directionsUrl = try values.decodeIfPresent(String.self, forKey: .directionsUrl)
//    reservationsSitesFirstCome = try values.decodeIfPresent(String.self, forKey: .reservationsSitesFirstCome)
//    name = try values.decodeIfPresent(String.self, forKey: .name)
//    regulationsOverview = try values.decodeIfPresent(String.self, forKey: .regulationsOverview)
//    latLong = try values.decodeIfPresent(String.self, forKey: .latLong)
//    description = try values.decodeIfPresent(String.self, forKey: .description)
//    reservationsSitesReservable = try values.decodeIfPresent(String.self, forKey: .reservationsSitesReservable)
//    parkCode = try values.decodeIfPresent(String.self, forKey: .parkCode)
//    amenities = try values.decodeIfPresent(Amenities.self, forKey: .amenities)
//    id = try values.decodeIfPresent(Int.self, forKey: .id)
//    reservationsDescription = try values.decodeIfPresent(String.self, forKey: .reservationsDescription)
//  }

}
