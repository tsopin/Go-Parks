//
//  GetCampgroundData.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-08-20.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import Foundation

struct GetCampgroundData : Codable {
  
  let total : Int?
  let data : [CampgroundData]?
  let limit : Int?
  let start : Int?
  
  enum CodingKeys: String, CodingKey {
    
    case total = "total"
    case data = "data"
    case limit = "limit"
    case start = "start"
  }
  
  init(total: Int, data: [CampgroundData], limit: Int, start: Int) {
    self.total = total
    self.data = data
    self.limit = limit
    self.start = start
    
  }
}
