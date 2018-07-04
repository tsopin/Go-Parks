//
//  Data.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-04-30.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

struct ParksData : Codable, Equatable {
  
  let states : [String]
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
  var isFavorite : Bool
  
  static func == (lhs: ParksData, rhs: ParksData) -> Bool {
    return lhs.fullName == rhs.fullName
  }
}

struct State {
  let fullName: String
  let stateName: String
  let stateFlag: UIImage
  
  init(name: String, full: String, flag: UIImage ) {
    self.stateName = name
    self.stateFlag = flag
    self.fullName = full
  }
}

extension State: Equatable {
  static func == (lhs: State, rhs: State) -> Bool {
    return lhs.stateName == rhs.stateName
  }
}


