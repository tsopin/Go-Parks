//
//  Amenities.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-08-20.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Amenities : Codable {
  
  var trashRecyclingCollection : String?
  var toilets : [String]?
  var internetConnectivity : Bool?
  var showers : [String]?
  var cellPhoneReception : Bool?
  var laundry : Bool?
  var amphitheater : String?
  var dumpStation : Bool?
  var campStore : Bool?
  var staffOrVolunteerHostOnSite : String?
  var potableWater : [String]?
  var iceAvailableForSale : Bool?
  var firewoodForSale : Bool?
  var ampitheater : String?
  var foodStorageLockers : String?
  
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
  
  static func getAmenitiesFrom(_ dict: [String : JSON]) -> Amenities {
    
    var amenities = Amenities()
    
    amenities.trashRecyclingCollection = dict["trashRecyclingCollection"]?.stringValue
    
    let toilets = dict["toilets"]?.arrayValue
    let showers = dict["showers"]?.arrayValue
    let potableWater = dict["potableWater"]?.arrayValue
    
    var toiletsArray = [String]()
    var showersArray = [String]()
    var potableWaterArray = [String]()
    
    for i in toilets! {
      toiletsArray.append(i.stringValue)
    }
    for i in showers! {
      showersArray.append(i.stringValue)
    }
    for i in potableWater! {
      potableWaterArray.append(i.stringValue)
    }
    
    amenities.toilets = toiletsArray
    amenities.internetConnectivity = dict["internetConnectivity"]?.boolValue
    amenities.showers = [dict["showers"]!.stringValue]
    amenities.cellPhoneReception = dict["cellPhoneReception"]?.boolValue
    amenities.laundry = dict["laundry"]?.boolValue
    amenities.amphitheater = dict["amphitheater"]?.stringValue
    amenities.dumpStation = dict["dumpStation"]?.boolValue
    amenities.campStore = dict["campStore"]?.boolValue
    amenities.staffOrVolunteerHostOnSite = dict["staffOrVolunteerHostOnSite"]?.stringValue
    amenities.potableWater = [dict["potableWater"]!.stringValue]
    amenities.iceAvailableForSale = dict["iceAvailableForSale"]?.boolValue
    amenities.firewoodForSale = dict["firewoodForSale"]!.boolValue
    amenities.ampitheater = dict["ampitheater"]!.stringValue
    amenities.foodStorageLockers = dict["foodStorageLockers"]!.stringValue
    
    return amenities
  }
}
