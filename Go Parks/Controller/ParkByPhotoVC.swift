//
//  ParkByPhotoVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-15.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class ParkByPhotoVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ReceivePark {
  func parkReceived(data: ParksData) {
    //
  }
  
  
  @IBOutlet weak var photosCollectionView: UICollectionView!
  var selectedItem = Int()
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Service.instance.parksArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: ParkByPhotoCell.ID, for: indexPath) as! ParkByPhotoCell
    let park = Service.instance.parksArray[indexPath.row]
    
    cell.configeureCell(name: park.name, photo: UIImage(named: park.name)!)
    
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedItem = indexPath.row
    performSegue(withIdentifier: "parkDetailFromPhoto", sender: Any?.self)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    photosCollectionView.delegate = self
    photosCollectionView.dataSource = self
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "parkDetailFromPhoto" {
      
      let park = Service.instance.parksArray
      
      let destinationVC = segue.destination as! MapVC
      destinationVC.data = park[selectedItem]
      destinationVC.delegate = self
      
      print("Chosen Park \(park[selectedItem].fullName)")
      
    }
  }
  
}
