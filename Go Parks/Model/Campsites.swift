//
//  Campsites.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-08-20.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import Foundation
import SwiftyJSON


  struct Campsites : Codable {
    
    var other : Int?
    var group : Int?
    var horse : Int?
    var totalSites : Int?
    var tentOnly : Int?
    var electricalHookups : Int?
    var rvOnly : Int?
    var walkBoatTo : Int? 
    
    enum CodingKeys: String, CodingKey {
      
      case other = "other"
      case group = "group"
      case horse = "horse"
      case totalSites = "totalSites"
      case tentOnly = "tentOnly"
      case electricalHookups = "electricalHookups"
      case rvOnly = "rvOnly"
      case walkBoatTo = "walkBoatTo"
    }
    
    static func getCampsitesFrom(_ dict: [String : JSON]) -> Campsites {
      
      var campsite = Campsites()
      
      campsite.other = dict["other"]?.intValue
      campsite.group = dict["group"]?.intValue
      campsite.horse = dict["horse"]?.intValue
      campsite.totalSites = dict["totalSites"]?.intValue
      campsite.tentOnly = dict["tentOnly"]?.intValue
      campsite.electricalHookups = dict["electricalHookups"]?.intValue
      campsite.rvOnly = dict["rvOnly"]?.intValue
      campsite.walkBoatTo = dict["walkBoatTo"]?.intValue
      
      return campsite
    }
  }

