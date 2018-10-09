//
//  Accessibility.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-08-20.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Accessibility : Codable {
  
  var wheelchairAccess : String?
  var internetInfo : String?
  var rvAllowed : Int?
  var cellPhoneInfo : String?
  var fireStovePolicy : String?
  var rvMaxLength : Int?
  var additionalInfo : String?
  var trailerMaxLength : Int?
  var adaInfo : String?
  var rvInfo : String?
  var accessRoads : [String]?
  var trailerAllowed : Int?
  var classifications : [String]?
  
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
  

  static func getAccessibilityFrom(_ dict: [String : JSON]) -> Accessibility {
    
    var accessibility = Accessibility()
    
    let accessRoads = dict["accessRoads"]?.arrayValue
    var accessRoadsArray = [String]()
    
    let classifications = dict["accessRoads"]?.arrayValue
    var classificationsArray = [String]()
    
    
    for i in accessRoads! {
      accessRoadsArray.append(i.stringValue)
    }
    
    for i in classifications! {
      classificationsArray.append(i.stringValue)
    }
    
    accessibility.wheelchairAccess = dict["wheelchairAccess"]?.stringValue
    accessibility.internetInfo = dict["internetInfo"]?.stringValue
    accessibility.rvAllowed = dict["rvAllowed"]?.intValue
    accessibility.cellPhoneInfo = dict["cellPhoneInfo"]?.stringValue
    accessibility.fireStovePolicy = dict["fireStovePolicy"]?.stringValue
    accessibility.rvMaxLength = dict["rvMaxLength"]?.intValue
    accessibility.additionalInfo = dict["additionalInfo"]?.stringValue
    accessibility.trailerMaxLength = dict["trailerMaxLength"]?.intValue
    accessibility.adaInfo = dict["adaInfo"]?.stringValue
    accessibility.rvInfo = dict["rvInfo"]?.stringValue
    accessibility.accessRoads = accessRoadsArray
    accessibility.trailerAllowed = dict["trailerAllowed"]?.intValue
    accessibility.classifications = classificationsArray
    
    return accessibility
  }

}
