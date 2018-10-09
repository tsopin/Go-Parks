//
//  WelcomeVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-04-30.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
  
  private var parkToGo = Int()
  private let service = Service.instance
  private let analytics = FirebaseAnalytics.instance
  private let defaults = UserDefaults()
  
 // @IBOutlet weak private var logoBottomConstraint: NSLayoutConstraint!
  //@IBOutlet weak private var bottomFavoriteConstraint: NSLayoutConstraint!
 // @IBOutlet weak private var logoTopConstraint: NSLayoutConstraint!
 // @IBOutlet weak private var logoHeight: NSLayoutConstraint!
 // @IBOutlet weak private var heartTop: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    service.isFirstRun()
    adjustMainScreen()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.isNavigationBarHidden = true
    UIApplication.shared.statusBarStyle = .lightContent
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    self.navigationController?.isNavigationBarHidden = false
    UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
  }
  
  override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    goAhead()
  }
  
  private func goAhead() {
    analytics.lucky()
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "goAhead", sender: Any?.self)
    }
  }
  
  private func adjustMainScreen() {
    let screenSize : CGRect = UIScreen.main.bounds
    
    print("\(screenSize.width) \(screenSize.height)")
    
//    if service.getDevice() == "SE" {
//      print("SE")
//      logoBottomConstraint.constant = 0
//      logoHeight.constant = 140
//      heartTop.constant = 20
//    } else if service.getDevice() == "X" {
//      print("X")
//      logoBottomConstraint.constant = 50
//      bottomFavoriteConstraint.constant = 60
//    } else if service.getDevice() == "Pro12" {
//      print("PRO 12.9")
//      bottomFavoriteConstraint.constant = 50
//    } else if screenSize.width == 1024 {
//      print("PRO 12.9")
//      logoTopConstraint.constant = 250
//      logoBottomConstraint.constant = 220
//      bottomFavoriteConstraint.constant = 50
//    } else if screenSize.width == 375 {
//      print("PRO 8")
//      logoBottomConstraint.constant = 50
//    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goAhead" {
      parkToGo = Int.random(in: 0..<service.parksArray.count - 1)
      print(service.parksArray.count)
      let destinationVC = segue.destination as! ParkDetailsVC
      destinationVC.data = Service.instance.parksArray[parkToGo]
    }
  }
}


