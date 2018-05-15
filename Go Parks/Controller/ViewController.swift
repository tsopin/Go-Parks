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
        print(park.states)
      }
 
    } catch {
      print("eerrro")
    }
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
      destinationVC.data = parksArray[parkToGo]
      print("PARK \(parksArray[parkToGo].fullName) ")
      destinationVC.delegate = self
    }
  }
}

    
