//
//  Data.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-04-30.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

struct ParksData : Codable {
  
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
  let isFavorite : Bool

}

struct State {
  let stateName: String
  let stateFlag: UIImage
  
  init(name: String, flag: UIImage ) {
    self.stateName = name
    self.stateFlag = flag
  }
}
