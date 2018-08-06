//
//  FavoriteParksVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-30.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class FavoriteParksVC: UIViewController, FavoriteParksCellDelegate {
  
  @IBOutlet weak private var favoriteLabel: UILabel!
  @IBOutlet weak private var favoriteParksCollectionView: UICollectionView!
  
  private let service = Service.instance
  private var selectedItem = Int()
  private var chosenPark = Int()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.favoriteParksCollectionView.delaysContentTouches = false
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    if service.parksArray.filter({ $0.isFavorite == true }).count < 1 {
      favoriteLabel.text = "Favorites is Empty"
    } else {
      favoriteLabel.text = "Favorites"
    }
    
    DispatchQueue.main.async {
      self.favoriteParksCollectionView.reloadData()
    }
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
        } else if parkInCell.isFavorite == true {
          self.service.parksArray[i].isFavorite = false
          parkInCell.isFavorite = false
        }
        if service.parksArray.filter({ $0.isFavorite == true }).count < 1 {
          favoriteLabel.text = "Favorites is Empty"
        }
        self.service.saveParks(isFirstRun: false)
        DispatchQueue.main.async {
          self.favoriteParksCollectionView.reloadData()
        }
      }
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedItem = indexPath.row
    
    for i in 0..<service.parksArray.count {
      if service.parksArray[i].name == service.parksArray.filter({ $0.isFavorite == true })[selectedItem].name {
        chosenPark = i
      }
    }
    
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "parkDetailsFromFavorites", sender: Any?.self)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let screenSize : CGRect = UIScreen.main.bounds
    
    let width = service.collectionItemsResize(screenWidth: screenSize.width).width
    let height = service.collectionItemsResize(screenWidth: screenSize.width).height
    
    return CGSize(width: width, height: height)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "parkDetailsFromFavorites" {
      
      let park = Service.instance.parksArray
      let destinationVC = segue.destination as! ParkDetailsVC
      destinationVC.data = park[chosenPark]
      
    }
  }
  
  //  deinit {}
}

//MARK: - UICollectionView Methods
extension FavoriteParksVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return service.parksArray.filter({ $0.isFavorite == true }).count
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteParksCell.ID, for: indexPath) as! FavoriteParksCell
    let park = service.parksArray.filter({ $0.isFavorite == true })[indexPath.row]
    
    cell.delegate = self
    
    cell.configureCell(name: park.name, photo: UIImage(named: park.name)!, isFavorite: park.isFavorite)
    
    return cell
  }
}
