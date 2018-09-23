//
//  Campsites.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-08-20.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import Foundation

struct Campsites : Codable {
  
  struct Campsites : Codable {
    let other : Int?
    let group : Int?
    let horse : Int?
    let totalSites : Int?
    let tentOnly : Int?
    let electricalHookups : Int?
    let rvOnly : Int?
    let walkBoatTo : Int?
    
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
    
//    init(from decoder: Decoder) throws {
//      let values = try decoder.container(keyedBy: CodingKeys.self)
//      other = try values.decodeIfPresent(Int.self, forKey: .other)
//      group = try values.decodeIfPresent(Int.self, forKey: .group)
//      horse = try values.decodeIfPresent(Int.self, forKey: .horse)
//      totalSites = try values.decodeIfPresent(Int.self, forKey: .totalSites)
//      tentOnly = try values.decodeIfPresent(Int.self, forKey: .tentOnly)
//      electricalHookups = try values.decodeIfPresent(Int.self, forKey: .electricalHookups)
//      rvOnly = try values.decodeIfPresent(Int.self, forKey: .rvOnly)
//      walkBoatTo = try values.decodeIfPresent(Int.self, forKey: .walkBoatTo)
//    }
//
}
}
