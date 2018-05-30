//
//  FavoriteParksVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-30.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class FavoriteParksVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FavoriteParksCellDelegate {


  @IBOutlet weak var favoriteParksCollectionView: UICollectionView!
  let service = Service.instance
  var selectedItem = Int()
  
  override func viewDidLoad() {
        super.viewDidLoad()

    }
  override func viewWillAppear(_ animated: Bool) {
    DispatchQueue.main.async {
      self.favoriteParksCollectionView.reloadData()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return service.parksArray.filter({ $0.isFavorite == true }).count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteParksCell.ID, for: indexPath) as! FavoriteParksCell
    let park = service.parksArray.filter({ $0.isFavorite == true })[indexPath.row]
    
    cell.delegate = self
    
    cell.configeureCell(name: park.name, photo: UIImage(named: park.name)!, isFavorite: park.isFavorite)
    print("\(park.name) is favorite - \(park.isFavorite)")
    
    return cell
  }
  
  func favoritePressed(cell: FavoriteParksCell) {
    guard let indexPath = self.favoriteParksCollectionView.indexPath(for: cell) else {
      return
    }
    
    var parkInCell = service.parksArray.filter({ $0.isFavorite == true })[indexPath.row]
    
    for i in 0..<service.parksArray.count {
      
      if service.parksArray[i].name == parkInCell.name {
        
        if parkInCell.isFavorite == false {
          self.service.parksArray[i].isFavorite = true
          parkInCell.isFavorite = true
          print("\(self.service.parksArray[i].name) \(self.service.parksArray[i].isFavorite)")
          
        } else if parkInCell.isFavorite == true {
          self.service.parksArray[i].isFavorite = false
          parkInCell.isFavorite = false
          print("\(self.service.parksArray[i].name) \(self.service.parksArray[i].isFavorite)")
        }
        
        self.service.saveParks()
        self.favoriteParksCollectionView.reloadData()
        //        print("Tapped \(parkInCell.name) in array \(self.service.parksArray[i].name)")
      }
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedItem = indexPath.row
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "parkDetailsFromFavorites", sender: Any?.self)
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
  
  func dismissVC() {
    DispatchQueue.main.async {
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  @IBAction func backButton(_ sender: Any) {
    dismissVC()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "parkDetailsFromFavorites" {
      
      let park = Service.instance.parksArray
      let destinationVC = segue.destination as! MapVC
      destinationVC.data = park[selectedItem]
      
      print("Chosen Park \(park[selectedItem].fullName)")
    }
  }

}
