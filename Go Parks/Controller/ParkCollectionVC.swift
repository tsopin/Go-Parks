//
//  ParkCollectionVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-15.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class ParkCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ParkByStateCellDelegate {
  
  @IBOutlet weak var stateNameLabel: UILabel!
  @IBOutlet weak var parkByStateCollectionView: UICollectionView!
  
  var chosenState : String?
  var selectedItem = Int()
  let service = Service.instance
  var chosenPark = Int()
  
  override func viewWillAppear(_ animated: Bool) {
    stateNameLabel.text = chosenState?.longStateName()
    DispatchQueue.main.async {
      self.parkByStateCollectionView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.parkByStateCollectionView.delaysContentTouches = false
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return service.parksArray.filter({ $0.states.contains("\(chosenState!)") }).count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ParkByStateCell.ID, for: indexPath) as! ParkByStateCell
    let park = service.parksArray.filter({ $0.states.contains("\(chosenState!)") })[indexPath.row]
    
    cell.configeureCell(name: park.name, photo: UIImage(named: park.name)!, isFavorite: park.isFavorite)
    
    cell.delegate = self
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedItem = indexPath.row
    
    for i in 0..<service.parksArray.count {
      if service.parksArray[i].name == service.parksArray.filter({ $0.states.contains("\(chosenState!)") })[selectedItem].name {
        chosenPark = i
//        print("\(service.parksArray.filter({ $0.states.contains("\(chosenState!)") })[selectedItem].name) = \(service.parksArray[i].name) number \(i)")
      }
    }
    
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "parkDetails", sender: Any?.self)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let screenSize : CGRect = UIScreen.main.bounds
    var widthCell = 100
    var heightCell = 100
    
//    //iPhone X
//    if screenSize.width == 750 {
//      widthCell = 355
//      heightCell = 215
//    }
    
    //iPhone SE 5
    if screenSize.width == 320 {
      widthCell = 300
      heightCell = 215
    }
    
    //iPhone 6 7
    if screenSize.width == 375 {
      widthCell = 350
      heightCell = 215
    }
    
    //iPhone 6+ 7+
    if screenSize.width == 414 {
      widthCell = 390
      heightCell = 215
    }
    //iPadPro 12
    if screenSize.width == 1024 {
      widthCell = 1002
      heightCell = 460
    }
    return CGSize(width: widthCell, height: heightCell)
  }
  
  func favoritePressed(cell: ParkByStateCell) {
    guard let indexPath = self.parkByStateCollectionView.indexPath(for: cell) else {
      return
    }
    
    let parkInCell = service.parksArray.filter({ $0.states.contains("\(chosenState!)") })[indexPath.row]
    
    for i in 0..<service.parksArray.count {
      
      if service.parksArray[i].name == parkInCell.name {
        
        if parkInCell.isFavorite == false {
          self.service.parksArray[i].isFavorite = true          
        } else if parkInCell.isFavorite == true {
          self.service.parksArray[i].isFavorite = false
        }
        self.service.saveParks()
      }
    }
    
    DispatchQueue.main.async {
      self.parkByStateCollectionView.reloadItems(at: [indexPath])
    }
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "parkDetails" {
      
      let destinationVC = segue.destination as! MapVC
      destinationVC.data = service.parksArray[chosenPark]
      
      //      print("Chosen Park \(service.parksArray[chosenPark].fullName)")
      
    }
  }
}



