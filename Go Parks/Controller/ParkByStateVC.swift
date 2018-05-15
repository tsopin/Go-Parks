//
//  ParkByStateVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-14.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit
import ExpandableCell

class ParkByStateVC: UIViewController, ExpandableDelegate {
  
  @IBOutlet weak var statesTableView: ExpandableTableView!
  
  var statesArray = [State]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    statesTableView.expandableDelegate = self
    statesTableView.animation = .automatic
    
    statesTableView.register(UINib(nibName: "StateCell", bundle: nil), forCellReuseIdentifier: StateCell.ID)
    statesTableView.register(UINib(nibName: "ParkState", bundle: nil), forCellReuseIdentifier: ParkCell.ID)

    for i in Service.instance.stateNamesArray {
      statesArray.append(State.init(name: i.longStateName(), flag: UIImage(named: i)!))
    }

  }
  
  func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
    
    let cell = statesTableView.dequeueReusableCell(withIdentifier: ParkCell.ID) as! ParkCell
    
    return [cell]
    
  }
  
  func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
  
  func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
    return Service.instance.stateNamesArray.count  }
  
  func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = statesTableView.dequeueReusableCell(withIdentifier: StateCell.ID) as! StateCell
    
   
    
    cell.configeureCell(stateName: statesArray[indexPath.row].stateName, stateFlag: statesArray[indexPath.row].stateFlag)
    
    return cell
  }
  
  func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
    return [65]
  }
  
}






















