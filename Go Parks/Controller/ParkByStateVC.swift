//
//  ParkByStateVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-14.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class ParkByStateVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  //  func parksForStatesRecieved(data: String) {
  //    //
  //  }
  
  @IBOutlet weak var statesTableView: UITableView!
  
  var statesArray = [State]()
  var selectedRow = Int()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    statesTableView.delegate = self
    statesTableView.dataSource = self
    
    for i in Service.instance.stateNamesArray {
      statesArray.append(State.init(name: i, flag: UIImage(named: i)!))
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Service.instance.stateNamesArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = statesTableView.dequeueReusableCell(withIdentifier: StateCell.ID) as! StateCell
    
    let state = statesArray[indexPath.row]
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
    performSegue(withIdentifier: "parkByState", sender: Any?.self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "parkByState" {
      let destinationVC = segue.destination as! ParkCollectionVC
      destinationVC.chosenState = Service.instance.stateNamesArray[selectedRow]
      print("Chosen State \(Service.instance.stateNamesArray[selectedRow].longStateName())")
    }
  }
}






















