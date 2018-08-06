//
//  ListOfStatesVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-14.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class ListOfStatesVC: UIViewController {
  
  @IBOutlet weak var statesTableView: UITableView!
  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var topConstraint: NSLayoutConstraint!
  
  private var statesArray = [State]()
  private var filtredStatesArray = [State]()
  private var selectedRow = Int()
  private let searchController = UISearchController(searchResultsController: nil)
  let service = Service.instance
  var chosenState = Int()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    statesTableView.delegate = self
    statesTableView.dataSource = self
    statesTableView.delaysContentTouches = false
    
    NotificationCenter.default.addObserver(self, selector:#selector(ListOfStatesVC.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector:#selector(ListOfStatesVC.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
    for i in service.stateNamesArray {
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
  
  @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
    
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
      let destinationVC = segue.destination as! ParkByStateVC
      destinationVC.chosenState = service.stateNamesArray[chosenState]
    }
  }
  
//  deinit {}
}

//MARK: - UITableView Methods
extension ListOfStatesVC: UITableViewDelegate, UITableViewDataSource {
  
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
    let count = service.parksArray.filter({ $0.states.contains(state.stateName) }).count
    var parksCount = String()
    
    if count == 1 {
      parksCount = "\(count) park"
    } else {
      parksCount = "\(count) parks"
    }
    
    cell.configureCell(stateName: state.stateName.longStateName(), stateFlag: state.stateFlag, parksCount: parksCount )
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    selectedRow = indexPath.row
    
    
    if isFiltering() {
      
      for i in 0..<statesArray.count {
        
        if filtredStatesArray[selectedRow].stateName == statesArray[i].stateName {
          chosenState = i
        }
      }
    } else {
      chosenState = selectedRow
    }
    
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "parkByState", sender: Any?.self)
    }
  }
}

// MARK: UISearch Methods
extension ListOfStatesVC: UISearchResultsUpdating {
  
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
}



















