//
//  Service.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-14.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class Service {
  
  static let instance = Service()
  
  var parksArray = [ParksData]()
  
  
  func getCountryList(){
    let decoder = JSONDecoder()
    let file = Bundle.main.url(forResource: "parks", withExtension: "json")
    
    do {
      
      let data = try Data(contentsOf: file!)
      
      let parks = try decoder.decode([ParksData].self, from: data)
      
      for park in parks {
        parksArray.append(park)
        print(park.states)
      }
      
    } catch {
      print("eerrro")
    }
  }
  
  let stateNamesArray = [
                 "AK",
                 "AR",
                 "AZ",
                 "CA",
                 "CO",
//                 "CT",
                 "DC",
//                 "DE",
                 "FL",
//                 "GA",
                 "HI",
//                 "IA",
                 "ID",
//                 "IL",
//                 "IN",
//                 "KS",
                 "KY",
//                 "LA",
//                 "MA",
//                 "MD",
                 "ME",
                 "MI",
                 "MN",
//                 "MO",
//                 "MS",
                 "MT",
                 "NC",
//                 "ND",
//                 "NE",
//                 "NH",
//                 "NJ",
                 "NM",
                 "NV",
                 "NY",
                 "OH",
//                 "OK",
                 "OR",
//                 "PA",
//                 "RI",
                 "SC",
                 "SD",
                 "TN",
                 "TX",
                 "UT",
                 "VA",
                 "VI",
//                 "VT",
                 "WA",
                 "WI",
//                 "WV",
                 "WY"]
  
  
  let parksByState = [ "AK":["Alagnak","Wrangell - St Elias","Aniakchak","Denali","Gates Of The Arctic","Glacier Bay","Katmai","Kenai Fjords","Kobuk Valley","Lake Clark"],
                       "AL":[""],
                       "AR":[""],
                       "AZ":[""],
                       "CA":[""],
                       "CO":[""],
                       "CT":[""],
                       "DC":[""],
                       "DE":[""],
                       "FL":[""],
                       "GA":[""],
                       "HI":[""],
                       "IA":[""],
                       "ID":[""],
                       "IL":[""],
                       "IN":[""],
                       "KS":[""],
                       "KY":[""],
                       "LA":[""],
                       "MA":[""],
                       "MD":[""],
                       "ME":[""],
                       "MI":[""],
                       "MN":[""],
                       "MO":[""],
                       "MS":[""],
                       "MT":[""],
                       "NC":[""],
                       "ND":[""],
                       "NE":[""],
                       "NH":[""],
                       "NJ":[""],
                       "NM":[""],
                       "NV":[""],
                       "NY":[""],
                       "OH":[""],
                       "OK":[""],
                       "OR":[""],
                       "PA":[""],
                       "RI":[""],
                       "SC":[""],
                       "SD":[""],
                       "TN":[""],
                       "TX":[""],
                       "UT":[""],
                       "VA":[""],
                       "VI":[""],
                       "VT":[""],
                       "WA":[""],
                       "WI":[""],
                       "WV":[""],
                       "WY":[""]
  ]
  
  
  
}
