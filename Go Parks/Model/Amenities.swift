//
//  Amenities.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-08-20.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import Foundation

struct Amenities : Codable {
  
  let trashRecyclingCollection : String?
  let toilets : [String]?
  let internetConnectivity : Bool?
  let showers : [String]?
  let cellPhoneReception : Bool?
  let laundry : Bool?
  let amphitheater : String?
  let dumpStation : Bool?
  let campStore : Bool?
  let staffOrVolunteerHostOnSite : String?
  let potableWater : [String]?
  let iceAvailableForSale : Bool?
  let firewoodForSale : Bool?
  let ampitheater : String?
  let foodStorageLockers : String?
  
  enum CodingKeys: String, CodingKey {
    
    case trashRecyclingCollection = "trashRecyclingCollection"
    case toilets = "toilets"
    case internetConnectivity = "internetConnectivity"
    case showers = "showers"
    case cellPhoneReception = "cellPhoneReception"
    case laundry = "laundry"
    case amphitheater = "amphitheater"
    case dumpStation = "dumpStation"
    case campStore = "campStore"
    case staffOrVolunteerHostOnSite = "staffOrVolunteerHostOnSite"
    case potableWater = "potableWater"
    case iceAvailableForSale = "iceAvailableForSale"
    case firewoodForSale = "firewoodForSale"
    case ampitheater = "ampitheater"
    case foodStorageLockers = "foodStorageLockers"
  }
  
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//    trashRecyclingCollection = try values.decodeIfPresent(String.self, forKey: .trashRecyclingCollection)
//    toilets = try values.decodeIfPresent([String].self, forKey: .toilets)
//    internetConnectivity = try values.decodeIfPresent(Bool.self, forKey: .internetConnectivity)
//    showers = try values.decodeIfPresent([String].self, forKey: .showers)
//    cellPhoneReception = try values.decodeIfPresent(Bool.self, forKey: .cellPhoneReception)
//    laundry = try values.decodeIfPresent(Bool.self, forKey: .laundry)
//    amphitheater = try values.decodeIfPresent(String.self, forKey: .amphitheater)
//    dumpStation = try values.decodeIfPresent(Bool.self, forKey: .dumpStation)
//    campStore = try values.decodeIfPresent(Bool.self, forKey: .campStore)
//    staffOrVolunteerHostOnSite = try values.decodeIfPresent(Bool.self, forKey: .staffOrVolunteerHostOnSite)
//    potableWater = try values.decodeIfPresent([String].self, forKey: .potableWater)
//    iceAvailableForSale = try values.decodeIfPresent(Bool.self, forKey: .iceAvailableForSale)
//    firewoodForSale = try values.decodeIfPresent(Bool.self, forKey: .firewoodForSale)
//    ampitheater = try values.decodeIfPresent(String.self, forKey: .ampitheater)
//    foodStorageLockers = try values.decodeIfPresent(Bool.self, forKey: .foodStorageLockers)
//  }

}
