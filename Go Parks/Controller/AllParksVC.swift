//
//  ParkByPhotoVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-15.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class AllParksVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AllParksCellDelegate {
  
  @IBOutlet weak var allParksCollectionView: UICollectionView!
  let service = Service.instance
  
  override func viewWillAppear(_ animated: Bool) {
    DispatchQueue.main.async {
      self.allParksCollectionView.reloadData()
    }
  }
  
  var selectedItem = Int()
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return service.parksArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllParksCell.ID, for: indexPath) as! AllParksCell
    let park = service.parksArray[indexPath.row]
    
    cell.delegate = self
    
    cell.configeureCell(name: park.name, photo: UIImage(named: park.name)!, isFavorite: park.isFavorite)
    print("\(park.name) is favorite - \(park.isFavorite)")
    
    return cell
  }
  
  func favoritePressed(cell: AllParksCell) {
    guard let indexPath = self.allParksCollectionView.indexPath(for: cell) else {
      return
    }
    
    if self.service.parksArray[indexPath.row].isFavorite == false {
      self.service.parksArray[indexPath.row].isFavorite = true
      print(self.service.parksArray[indexPath.row].isFavorite)
      
    } else if self.service.parksArray[indexPath.row].isFavorite == true {
      self.service.parksArray[indexPath.row].isFavorite = false
      print(self.service.parksArray[indexPath.row].isFavorite)
    }
    self.service.saveParks()
      self.allParksCollectionView.reloadData()
    print("Button tapped on row \(indexPath.row)")
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
    
  }
  
  
  
  @IBAction func backGesture(_ sender: Any) {
    dismissVC()
  }
  @IBAction func backButton(_ sender: Any) {
    dismissVC()
  }
  
  func dismissVC() {
    DispatchQueue.main.async {
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
