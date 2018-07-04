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
  
  @IBOutlet weak private var logoBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak private var bottomFavoriteConstraint: NSLayoutConstraint!
  @IBOutlet weak private var logoTopConstraint: NSLayoutConstraint!
  @IBOutlet weak private var logoHeight: NSLayoutConstraint!
  @IBOutlet weak private var heartTop: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    service.getListOfParks(isFirstRun: false)
    service.firstRun()
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
  
  override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
    goAhead()
  }
  
  private func goAhead() {
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "goAhead", sender: Any?.self)
    }
  }
  
  private func adjustMainScreen() {
    let screenSize : CGRect = UIScreen.main.bounds
    
    print("\(screenSize.width) \(screenSize.height)")
    
    if screenSize.width == 320 {
      print("SE")
      logoBottomConstraint.constant = 0
      logoHeight.constant = 140
      heartTop.constant = 20
    } else if screenSize.width == 375 && screenSize.height == 812 {
      print("X")
      logoBottomConstraint.constant = 50
      bottomFavoriteConstraint.constant = 60
    } else if screenSize.width == 768 || screenSize.width == 834  {
      print("PRO 12.9")
      bottomFavoriteConstraint.constant = 50
    } else if screenSize.width == 1024 {
      print("PRO 12.9")
      logoTopConstraint.constant = 250
      logoBottomConstraint.constant = 220
      bottomFavoriteConstraint.constant = 50
    } else if screenSize.width == 375 {
      print("PRO 8")
      logoBottomConstraint.constant = 50
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goAhead" {
      parkToGo = Int(Double.random(min: 0, max: 64))
      let destinationVC = segue.destination as! MapVC
      destinationVC.data = Service.instance.parksArray[parkToGo]
    }
  }
}


