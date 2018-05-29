//
//  ParkCollectionVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-15.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class ParkCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
//  @IBOutlet weak var parksCollectionView: UICollectionView!
  @IBOutlet weak var stateNameLabel: UILabel!
  
  var parkByStateArray = [ParksData]()
  var chosenState : String?
  var selectedItem = Int()
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return parkByStateArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ParkCollectionCell.ID, for: indexPath) as! ParkCollectionCell
    let park = parkByStateArray[indexPath.row]
    
    cell.dropShadow()
    cell.configeureCell(name: park.name, photo: UIImage(named: park.name)!)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedItem = indexPath.row
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "parkDetails", sender: Any?.self)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    parkByStateArray.removeAll()
//    parksCollectionView.dataSource = self
//    parksCollectionView.delegate = self
    stateNameLabel.text = chosenState?.longStateName()
    
    for i in Service.instance.parksArray.filter({ $0.states.contains("\(chosenState!)") }) {
      
      parkByStateArray.append(i)
      print("Parsk for state \(i.name)")
    }
  }
  
  @IBAction func backButton(_ sender: Any) {
    dismissVC()
  }
  
  @IBAction func backGesture(_ sender: Any) {
    dismissVC()
  }
  
  func dismissVC() {
    DispatchQueue.main.async{
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let screenSize : CGRect = UIScreen.main.bounds
    var widthCell = 100
    var heightCell = 100
    
    //iPhone X
    if screenSize.width == 750 {
      
      widthCell = 355
      heightCell = 185
      
    }
    
    //iPhone SE 5
    if screenSize.width == 320 {
      
      widthCell = 300
      heightCell = 185
      
    }
    
    //iPhone 6 7
    if screenSize.width == 375 {
      
      widthCell = 350
      heightCell = 185
      
    }
    
    //iPhone 6+ 7+
    if screenSize.width == 414 {
      
      widthCell = 390
      heightCell = 185
      
    }
    return CGSize(width: widthCell, height: heightCell)
    
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "parkDetails" {
      let destinationVC = segue.destination as! MapVC
      destinationVC.data = parkByStateArray[selectedItem]
      
      print("Chosen Park \(parkByStateArray[selectedItem].fullName)")
      
    }
  }
}



