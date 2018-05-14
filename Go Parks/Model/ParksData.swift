//
//  Data.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-04-30.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

struct ParksData : Codable {
  
  let states : String
  let lat : String
  let long: String
  let description : String
  let designation : String
  let parkCode : String
  let id : String
  let directionsInfo : String
  let directionsUrl : String
  let fullName : String
  let url : String
  let weatherInfo : String
  let name : String
//
//  enum CodingKeys: String, CodingKey {
//
//    case states = "states"
//    case latLong = "latLong"
//    case description = "description"
//    case designation = "designation"
//    case parkCode = "parkCode"
//    case id = "id"
//    case directionsInfo = "directionsInfo"
//    case directionsUrl = "directionsUrl"
//    case fullName = "fullName"
//    case url = "url"
//    case weatherInfo = "weatherInfo"
//    case name = "name"
//  }
//
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//    states = try values.decodeIfPresent(String.self, forKey: .states)
//    latLong = try values.decodeIfPresent(String.self, forKey: .latLong)
//    description = try values.decodeIfPresent(String.self, forKey: .description)
//    designation = try values.decodeIfPresent(String.self, forKey: .designation)
//    parkCode = try values.decodeIfPresent(String.self, forKey: .parkCode)
//    id = try values.decodeIfPresent(String.self, forKey: .id)
//    directionsInfo = try values.decodeIfPresent(String.self, forKey: .directionsInfo)
//    directionsUrl = try values.decodeIfPresent(String.self, forKey: .directionsUrl)
//    fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
//    url = try values.decodeIfPresent(String.self, forKey: .url)
//    weatherInfo = try values.decodeIfPresent(String.self, forKey: .weatherInfo)
//    name = try values.decodeIfPresent(String.self, forKey: .name)
//  }
}

