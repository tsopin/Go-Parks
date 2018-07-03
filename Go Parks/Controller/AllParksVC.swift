//
//  ParkByPhotoVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-15.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class AllParksVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AllParksCellDelegate, UISearchResultsUpdating {
  
  @IBOutlet weak var allParksCollectionView: UICollectionView!
  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  
  let service = Service.instance
  var selectedItem = Int()
  let searchController = UISearchController(searchResultsController: nil)
  var filtredParks = [ParksData]()
  var chosenPark = Int()
  
  
  override func viewWillAppear(_ animated: Bool) {
    filtredParks.removeAll()
    
    DispatchQueue.main.async {
      self.allParksCollectionView.reloadData()
    }
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
  }
  
  // MARK: Search
  
  func updateSearchResults(for searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text!)
  }
  
  func filterContentForSearchText(_ searchText: String, scope: String = "All") {
    
    filtredParks = service.parksArray.filter({ (park: ParksData) -> Bool in
      return park.fullName.lowercased().contains(searchText.lowercased()) || park.designation.lowercased().contains(searchText.lowercased())
    })
    allParksCollectionView.reloadData()
    scrollToTop()
  }
  
  func isFiltering() -> Bool {
    return searchController.isActive && !(searchController.searchBar.text?.isEmpty)!
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if isFiltering() {
      return filtredParks.count
    } else {
      return service.parksArray.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllParksCell.ID, for: indexPath) as! AllParksCell
    //    let park = service.parksArray[indexPath.row]
    let park = isFiltering() ? filtredParks[indexPath.row] : service.parksArray[indexPath.row]
    
    print("IS FILTERING \(isFiltering())")
    
    cell.delegate = self
    
    cell.configeureCell(name: park.name, photo: UIImage(named: park.name)!, isFavorite: park.isFavorite)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedItem = indexPath.row
    
    if filtredParks.count > 0 {
      
      for i in 0..<service.parksArray.count {
        
        if filtredParks[selectedItem].id == service.parksArray[i].id {
          chosenPark = i
          
          print("Chosen number \(chosenPark) is  \(service.parksArray[chosenPark].name)")
          
        }
      }
      //      print(selectedItem)
    } else {
      chosenPark = selectedItem
    }
    
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "parkDetailFromPhoto", sender: Any?.self)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let screenSize : CGRect = UIScreen.main.bounds
    
    let width = service.collectionItemsResize(screenWidth: screenSize.width).0
    let height = service.collectionItemsResize(screenWidth: screenSize.width).1
    
    return CGSize(width: width, height: height)
    
  }
  
  func favoritePressed(cell: AllParksCell) {
    guard let indexPath = self.allParksCollectionView.indexPath(for: cell) else {
      return
    }
    
    var parkInCell = service.parksArray[indexPath.row]
    
    if isFiltering() {
      parkInCell = filtredParks[indexPath.row]
      
      print("Park In Cell Filtred \(parkInCell.name)")
      for i in 0..<service.parksArray.count {
        
        if filtredParks[indexPath.row].id == service.parksArray[i].id {
          
          if service.parksArray[i].isFavorite == false {
            service.parksArray[i].isFavorite = true
            filtredParks[indexPath.row].isFavorite = true
//            print("\(parkInDB[i].name) \(parkInDB[i].isFavorite)")
          } else if service.parksArray[i].isFavorite == true {
            service.parksArray[i].isFavorite = false
            filtredParks[indexPath.row].isFavorite = false
//            print("\(parkInDB[i].name) \(parkInDB[i].isFavorite)")
          }
          self.service.saveParks()
        }
      }
      
    } else {
      
      print("Park In Cell UNFiltred \(parkInCell.name)")
      
      for i in 0..<service.parksArray.count {
        
        if service.parksArray[i].id == parkInCell.id {
          
          if parkInCell.isFavorite == false {
            self.service.parksArray[i].isFavorite = true
            print("\(parkInCell.name) \(parkInCell.isFavorite)")
          } else if parkInCell.isFavorite == true {
            self.service.parksArray[i].isFavorite = false
            print("\(parkInCell.name) \(parkInCell.isFavorite)")
          }
//          self.allParksCollectionView.reloadData()
          self.service.saveParks()
        }
      }
    }
    
    DispatchQueue.main.async {
      print("Reloaded")
      self.allParksCollectionView.reloadItems(at: [indexPath])
    }
  }
  
  
  @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
    
    print("SEARCH")
    if navigationItem.searchController?.searchBar.isFirstResponder == false {
      navigationItem.searchController?.searchBar.becomeFirstResponder()
    }
    
  }
  
  //  Move UItableView above a keyboard
  @objc func keyboardWillShow(notification : NSNotification) {
    
    let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size
    self.bottomConstraint.constant = keyboardSize.height
    UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
      
    })
  }
  
  @objc func keyboardWillHide(notification : NSNotification) {
    self.bottomConstraint.constant = 0
  }
  
  func scrollToTop() {
    
    if self.filtredParks.count - 1 <= 0 {
      return
    }
    let indexPath = IndexPath(item: 0, section: 0)
    DispatchQueue.main.async {
      self.allParksCollectionView?.scrollToItem(at: indexPath, at: .top, animated: true)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "parkDetailFromPhoto" {
      
      let park = Service.instance.parksArray
      let destinationVC = segue.destination as! MapVC
      destinationVC.data = park[chosenPark]
      print("Sent \(park[chosenPark].name)")
      
    }
  }

  deinit {
    print("deinit called")
  }
}
