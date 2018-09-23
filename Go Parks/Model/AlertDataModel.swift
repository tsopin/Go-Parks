//
//  AlertData.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-08-20.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import Foundation

struct AlertData : Codable {
  
  let title : String?
  let id : String?
  let description : String?
  let category : String?
  let url : String?
  let parkCode : String?

  enum CodingKeys: String, CodingKey {

    case title = "title"
    case id = "id"
    case description = "description"
    case category = "category"
    case url = "url"
    case parkCode = "parkCode"
  }
}
// Toast Alert
// Dodo Alert
