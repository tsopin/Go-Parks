//
//  ViewController.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-04-30.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ReceivePark {
  func parkReceived(data: ParksData) {
    //
  }
  
  var parkToGo = Int()
  
  var parksArray = [ParksData]()

  override func viewDidLoad() {
    super.viewDidLoad()
    getCountryList()
  }

  func getCountryList(){
    let decoder = JSONDecoder()
    let file = Bundle.main.url(forResource: "parks", withExtension: "json")
    
    do {
      
      let data = try Data(contentsOf: file!)
      
      let parks = try decoder.decode([ParksData].self, from: data)
      
      for park in parks {
        parksArray.append(park)
        print(park.lat)
      }
 
    } catch {
      print("eerrro")
    }
  }

  
  @IBAction func testButton(_ sender: Any) {
    
    parkToGo = Int(Double.random(min: 0, max: 82))
    print("RANDOM \(parkToGo)")
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "goAhead" {
      
      let destinationVC = segue.destination as! MapVC
      destinationVC.data = parksArray[parkToGo]
      destinationVC.delegate = self
    }
  }
}

    
