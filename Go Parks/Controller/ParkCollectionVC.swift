//
//  ParkCollectionVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-15.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class ParkCollectionVC: UIViewController, ParkByStateCellDelegate {
  
  @IBOutlet weak private var stateNameLabel: UILabel!
  @IBOutlet weak private var parkByStateCollectionView: UICollectionView!
  
  var chosenState : String?
  private var selectedItem = Int()
  private let service = Service.instance
  private var chosenPark = Int()
  
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
    }
  }
  
  deinit {}
}

//MARK: - UICollectionView Methods

extension ParkCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
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
      }
    }
    
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "parkDetails", sender: Any?.self)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let screenSize : CGRect = UIScreen.main.bounds
    let width = service.collectionItemsResize(screenWidth: screenSize.width).width
    let height = service.collectionItemsResize(screenWidth: screenSize.width).height
    
    return CGSize(width: width, height: height)
    
  }
}

