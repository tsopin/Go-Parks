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
  
  @IBOutlet weak var logoConstraint: NSLayoutConstraint!
 
  @IBOutlet weak var bottomFavoriteConstraint: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    service.getListOfParks()
    service.loadParks()
    
    let screenSize : CGRect = UIScreen.main.bounds
    print(screenSize.width)
    if screenSize.width == 320 {
     logoConstraint.constant = 15
    } else if screenSize.width == 1024 {
      logoConstraint.constant = 130
      bottomFavoriteConstraint.constant = 100
    } else if screenSize.width == 375 {
      logoConstraint.constant = 70
      bottomFavoriteConstraint.constant = 60
    } 
    
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
  
  @IBAction func favoriteButton(_ sender: UIButton) {
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goAhead" {
      parkToGo = Int(Double.random(min: 0, max: 64))
      let destinationVC = segue.destination as! MapVC
      destinationVC.data = Service.instance.parksArray[parkToGo]
    }
  }
}


