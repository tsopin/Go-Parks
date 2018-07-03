//
//  ListOfStatesVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-14.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class ListOfStatesVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
  
  @IBOutlet weak var statesTableView: UITableView!
  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var topConstraint: NSLayoutConstraint!
  
  var statesArray = [State]()
  var filtredStatesArray = [State]()
  var selectedRow = Int()
  let searchController = UISearchController(searchResultsController: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    statesTableView.delegate = self
    statesTableView.dataSource = self
    
    NotificationCenter.default.addObserver(self, selector:#selector(ListOfStatesVC.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector:#selector(ListOfStatesVC.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
    for i in Service.instance.stateNamesArray {
      statesArray.append(State.init(name: i, full: i.longStateName(), flag: UIImage(named: i)!))
    }
    
    navigationItem.searchController = searchController
    navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
    navigationItem.hidesSearchBarWhenScrolling = true
    definesPresentationContext = true
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Find State by Name or Code"
  }
  

  // MARK: Search
  
  func updateSearchResults(for searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text!)
  }
  
  func filterContentForSearchText(_ searchText: String, scope: String = "All") {
 
    filtredStatesArray = statesArray.filter({ (state: State) -> Bool in
      return state.stateName.lowercased().contains(searchText.lowercased()) || state.fullName.lowercased().contains(searchText.lowercased())
    })
    statesTableView.reloadData()
    scrollToTop()
  }
  
  func isFiltering() -> Bool {
    return searchController.isActive && !(searchController.searchBar.text?.isEmpty)!
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering() {
      return filtredStatesArray.count
    } else {
      return statesArray.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = statesTableView.dequeueReusableCell(withIdentifier: StateCell.ID) as! StateCell
   
    let state = isFiltering() ? filtredStatesArray[indexPath.row] : statesArray[indexPath.row]
    var count = Int()
    var parksCount = String()
    
    for _ in Service.instance.parksArray.filter({ $0.states.contains(state.stateName) }) {
      count = count + 1
    }
    
    if count == 1 {
      parksCount = "\(count) park"
    } else {
      parksCount = "\(count) parks"
    }
    
    cell.configeureCell(stateName: state.stateName.longStateName(), stateFlag: state.stateFlag, parksCount: parksCount )
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    selectedRow = indexPath.row
    
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "parkByState", sender: Any?.self)
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
    
    if self.filtredStatesArray.count - 1 <= 0 {
      return
    }
    let indexPath = IndexPath(item: 0, section: 0)
    DispatchQueue.main.async {
      self.statesTableView?.scrollToRow(at: indexPath, at: .top, animated: true)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "parkByState" {
      let destinationVC = segue.destination as! ParkCollectionVC
      destinationVC.chosenState = Service.instance.stateNamesArray[selectedRow]
      print("Chosen State \(Service.instance.stateNamesArray[selectedRow].longStateName())")
    }
  }
}






















