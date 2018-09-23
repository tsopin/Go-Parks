//
//  Analitycs.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-08-26.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import Foundation
import Firebase

class FirebaseAnalytics {
  
  static let instance = FirebaseAnalytics()
  
  func appOpen() {
    let params = ["appOpen":true]
    Analytics.logEvent("appLaunched", parameters: params)
  }
  
  func allParks(park: String) {
    let params = ["parkName":park]
    Analytics.logEvent("parkFormAll", parameters: params)
  }
  
  func byState(state: String) {
    let params = ["state":state]
    Analytics.logEvent("stateSelected", parameters: params)
  }
  
  func lucky() {
    let params = ["lucky":true]
    Analytics.logEvent("Random Park", parameters: params)
  }
  
  func addedToFavorite(park: String, screen: String) {
    var params = [String: String]()
    params = [screen: "Ull"]
    Analytics.logEvent("addToFavorite", parameters: params)
    print("Favorite - \(params)")
  }
  
  func directions(park: String) {
    let params = ["directionsOpen":park]
    Analytics.logEvent("directionsOpen", parameters: params)
  }
  
  func alertsOpen(park: String) {
    let params = ["alertsOpen":park]
    Analytics.logEvent("alertsOpen", parameters: params)
  }
  
  func logWebView(park: String) {
    let params = ["park":park]
    Analytics.logEvent("parkUrlOpen", parameters: params)
  }
  
}
