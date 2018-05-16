//
//  ParkCollectionVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-15.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

protocol ReceiveParksForState {
  func parksForStatesRecieved(data: String)
}

class ParkCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
  
  @IBOutlet weak var parksCollectionView: UICollectionView!
  
  var parkByStateArray = [ParksData]()
  var delegate : ReceiveParksForState?
  var chosenState : String?
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return parkByStateArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = parksCollectionView.dequeueReusableCell(withReuseIdentifier: ParkCollectionCell.ID, for: indexPath) as! ParkCollectionCell
    let park = parkByStateArray[indexPath.row]
    
    cell.configeureCell(name: park.fullName, photo: UIImage(named: park.name)!)
    
    return cell
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    parksCollectionView.dataSource = self
    parksCollectionView.delegate = self
    
    for i in Service.instance.parksArray.filter({ $0.states.contains("\(chosenState!)") }) {
      
      parkByStateArray.append(i)
      print("Parsk for state \(i.name)")
    }
    
  }
}



