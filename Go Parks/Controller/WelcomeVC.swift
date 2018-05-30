//
//  WelcomeVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-04-30.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
  
  var parkToGo = Int()
  let service = Service.instance
  
  override func viewDidLoad() {
    super.viewDidLoad()
    service.getListOfParks()
    service.loadParks()
    
    print(service.parksArray.filter({ $0.isFavorite == true }).count)
    
  }
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.isNavigationBarHidden = true
  }
  override func viewWillDisappear(_ animated: Bool) {
    self.navigationController?.isNavigationBarHidden = false
  }
  
  @IBAction func goSwipe(_ sender: Any) {
    goAhead()
  }
  override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
    goAhead()
  }
  
  func goAhead() {
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "goAhead", sender: Any?.self)
    }
  }
  @IBAction func favoriteButton(_ sender: Any) {
    //    for i in service.parksArray {
    //      i.isFavorite = false
    //    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goAhead" {
      parkToGo = Int(Double.random(min: 0, max: 64))
      let destinationVC = segue.destination as! MapVC
      destinationVC.data = Service.instance.parksArray[parkToGo]
    }
  }
}


