//
//  ParkByPhotoVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-15.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class ParkByPhotoVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  @IBOutlet weak var photosCollectionView: UICollectionView!
  
  var selectedItem = Int()
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Service.instance.parksArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ParkCollectionCell.ID, for: indexPath) as! ParkCollectionCell
    let park = Service.instance.parksArray[indexPath.row]
    
    cell.dropShadow()
    
    cell.configeureCell(name: park.name, photo: UIImage(named: park.name)!)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedItem = indexPath.row
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "parkDetailFromPhoto", sender: Any?.self)
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    photosCollectionView.delegate = self
//    photosCollectionView.dataSource = self
  }
  
  @IBAction func backGesture(_ sender: Any) {
    dismissVC()
  }
  @IBAction func backButton(_ sender: Any) {
    dismissVC()
  }
  
  func dismissVC() {
    DispatchQueue.main.async{
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "parkDetailFromPhoto" {
      
      let park = Service.instance.parksArray
      
      let destinationVC = segue.destination as! MapVC
      destinationVC.data = park[selectedItem]
      
      print("Chosen Park \(park[selectedItem].fullName)")
    }
  }
}
