//
//  Accessibility.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-08-20.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import Foundation

struct Accessibility : Codable {
  
  let wheelchairAccess : String?
  let internetInfo : String?
  let rvAllowed : Int?
  let cellPhoneInfo : String?
  let fireStovePolicy : String?
  let rvMaxLength : Int?
  let additionalInfo : String?
  let trailerMaxLength : Int?
  let adaInfo : String?
  let rvInfo : String?
  let accessRoads : [String]?
  let trailerAllowed : Int?
  let classifications : [String]?
  
  enum CodingKeys: String, CodingKey {
    
    case wheelchairAccess = "wheelchairAccess"
    case internetInfo = "internetInfo"
    case rvAllowed = "rvAllowed"
    case cellPhoneInfo = "cellPhoneInfo"
    case fireStovePolicy = "fireStovePolicy"
    case rvMaxLength = "rvMaxLength"
    case additionalInfo = "additionalInfo"
    case trailerMaxLength = "trailerMaxLength"
    case adaInfo = "adaInfo"
    case rvInfo = "rvInfo"
    case accessRoads = "accessRoads"
    case trailerAllowed = "trailerAllowed"
    case classifications = "classifications"
  }
  
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//    wheelchairAccess = try values.decodeIfPresent(String.self, forKey: .wheelchairAccess)
//    internetInfo = try values.decodeIfPresent(String.self, forKey: .internetInfo)
//    rvAllowed = try values.decodeIfPresent(Int.self, forKey: .rvAllowed)
//    cellPhoneInfo = try values.decodeIfPresent(String.self, forKey: .cellPhoneInfo)
//    fireStovePolicy = try values.decodeIfPresent(String.self, forKey: .fireStovePolicy)
//    rvMaxLength = try values.decodeIfPresent(Int.self, forKey: .rvMaxLength)
//    additionalInfo = try values.decodeIfPresent(String.self, forKey: .additionalInfo)
//    trailerMaxLength = try values.decodeIfPresent(Int.self, forKey: .trailerMaxLength)
//    adaInfo = try values.decodeIfPresent(String.self, forKey: .adaInfo)
//    rvInfo = try values.decodeIfPresent(String.self, forKey: .rvInfo)
//    accessRoads = try values.decodeIfPresent([String].self, forKey: .accessRoads)
//    trailerAllowed = try values.decodeIfPresent(Int.self, forKey: .trailerAllowed)
//    classifications = try values.decodeIfPresent([String].self, forKey: .classifications)
//  }

}
