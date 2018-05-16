//
//  WelcomeVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-04-30.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController, ReceivePark {
  func parkReceived(data: ParksData) {
    //
  }
  
  var parkToGo = Int()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    Service.instance.getCountryList()
  }



  @IBAction func goSwipe(_ sender: Any) {
    performSegue(withIdentifier: "goAhead", sender: Any?.self)
    
  }
  
  @IBAction func testButton(_ sender: Any) {
    

    print("RANDOM \(parkToGo)")
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "goAhead" {
      parkToGo = Int(Double.random(min: 0, max: 64))
      let destinationVC = segue.destination as! MapVC
      destinationVC.data = Service.instance.parksArray[parkToGo]
//      print("PARK \(parksArray[parkToGo].fullName) ")
      destinationVC.delegate = self
    }
  }
}

    