//
//  ParkByPhotoVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-15.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class AllParksVC: UIViewController, AllParksCellDelegate  {
  
  @IBOutlet weak private var allParksCollectionView: UICollectionView!
  @IBOutlet weak private var bottomConstraint: NSLayoutConstraint!
  
  private let service = Service.instance
  private var selectedItem = Int()
  private let searchController = UISearchController(searchResultsController: nil)
  private var filtredParks = [ParksData]()
  private var chosenPark = Int()
  
  override func viewWillAppear(_ animated: Bool) {
    updateSearchResults(for: searchController)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.allParksCollectionView.delaysContentTouches = false
    
    NotificationCenter.default.addObserver(self, selector:#selector(AllParksVC.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector:#selector(AllParksVC.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
    navigationItem.searchController = searchController
    navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
    navigationItem.hidesSearchBarWhenScrolling = true
    definesPresentationContext = true
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Find Park by Name or Designation"
    searchController.searchBar.returnKeyType = .search
  }
  
  func favoritePressed(cell: AllParksCell) {
    guard let indexPath = self.allParksCollectionView.indexPath(for: cell) else {
      return
    }
    
    var parkInCell = service.parksArray[indexPath.row]
    
    if isFiltering() {
      parkInCell = filtredParks[indexPath.row]
      
      for i in 0..<service.parksArray.count {
        
        if filtredParks[indexPath.row].id == service.parksArray[i].id {
          
          if service.parksArray[i].isFavorite == false {
            service.parksArray[i].isFavorite = true
            filtredParks[indexPath.row].isFavorite = true
          } else if service.parksArray[i].isFavorite == true {
            service.parksArray[i].isFavorite = false
            filtredParks[indexPath.row].isFavorite = false
          }
        }
      }
    } else {
      
      for i in 0..<service.parksArray.count {
        
        if service.parksArray[i].id == parkInCell.id {
          
          if parkInCell.isFavorite == false {
            self.service.parksArray[i].isFavorite = true
          } else if parkInCell.isFavorite == true {
            self.service.parksArray[i].isFavorite = false
          }
        }
      }
    }
    
    self.service.saveParks()
    
    DispatchQueue.main.async {
      self.allParksCollectionView.reloadItems(at: [indexPath])
    }
  }
  
  @IBAction private func searchButtonPressed(_ sender: UIBarButtonItem) {
    
    if !(navigationItem.searchController?.searchBar.isFirstResponder)! {
      navigationItem.searchController?.searchBar.becomeFirstResponder()
    } else {
      navigationItem.searchController?.searchBar.resignFirstResponder()
    }
  }
  
  //  Move UItableView above a keyboard
  @objc func keyboardWillShow(notification : NSNotification) {
    let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size
    self.bottomConstraint.constant = keyboardSize.height
    UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in })
  }
  
  @objc func keyboardWillHide(notification : NSNotification) {
    self.bottomConstraint.constant = 0
  }
  
  private func scrollToTop() {
//
//    if self.filtredParks.count - 1 <= 0 {
//      return
//    }
//
//    let indexPath = IndexPath(item: 0, section: 0)
//
//    DispatchQueue.main.async {
//      self.allParksCollectionView?.scrollToItem(at: indexPath, at: .top, animated: true)
//    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "parkDetailFromPhoto" {
      
      let park = Service.instance.parksArray
      let destinationVC = segue.destination as! MapVC
      destinationVC.data = park[chosenPark]
    }
  }
  
  deinit {}
}

//MARK: - UICollectionView Methods
extension AllParksVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if isFiltering() {
      return filtredParks.count
    } else {
      return service.parksArray.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllParksCell.ID, for: indexPath) as! AllParksCell
    let park = isFiltering() ? filtredParks[indexPath.row] : service.parksArray[indexPath.row]
    
    cell.delegate = self
    
    cell.configeureCell(name: park.name, photo: UIImage(named: park.name)!, isFavorite: park.isFavorite)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedItem = indexPath.row
    
    if isFiltering() {
      
      for i in 0..<service.parksArray.count {
        
        if filtredParks[selectedItem].id == service.parksArray[i].id {
          chosenPark = i
        }
      }
    } else {
      chosenPark = selectedItem
    }
    
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "parkDetailFromPhoto", sender: Any?.self)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let screenSize : CGRect = UIScreen.main.bounds
    
    let width = service.collectionItemsResize(screenWidth: screenSize.width).width
    let height = service.collectionItemsResize(screenWidth: screenSize.width).height
    
    return CGSize(width: width, height: height)
  }
}

// MARK: UISearch Methods
extension AllParksVC: UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text!)
  }
  
  func filterContentForSearchText(_ searchText: String, scope: String = "All") {
    
    filtredParks = service.parksArray.filter({ (park: ParksData) -> Bool in
      return park.fullName.lowercased().contains(searchText.lowercased()) || park.designation.lowercased().contains(searchText.lowercased())
    })
    
    DispatchQueue.main.async {
      self.allParksCollectionView.reloadData()
      self.scrollToTop()
    }
  }
  
  func isFiltering() -> Bool {
    return searchController.isActive && !(searchController.searchBar.text?.isEmpty)!
  }
  
}
