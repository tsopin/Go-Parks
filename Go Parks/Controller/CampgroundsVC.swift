//
//  CampgroundsVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-08-22.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class CampgroundsVC: UIViewController {
  
  @IBOutlet private weak var campgroundsTableView: UITableView!
  
  
  var recievedPark : String?
  var data : [CampgroundData]?
  
  private var chosenPark = CampgroundData()
  
  private var campgroundsArray = [CampgroundData]()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = recievedPark
    
    if (data?.count)! > 0 {
      campgroundsArray = data!
    }
    self.campgroundsTableView.delegate = self
    self.campgroundsTableView.dataSource = self
    
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    //    infoTextView.text = data
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "campgroundDetails" {
      let destinationVC = segue.destination as! CampgroundDescriptionVC
      destinationVC.data = chosenPark
    }
  }
  
}
extension CampgroundsVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = campgroundsTableView.dequeueReusableCell(withIdentifier: "campgroundCell") as! CampgroundCell
    
    let ololo = campgroundsArray[indexPath.row]
    
    cell.configureCell(name: ololo.name ?? "", totalSties: ololo.campsites?.totalSites ?? 0, rvSites: ololo.campsites?.rvOnly ?? 0, tentSites: ololo.campsites?.tentOnly ?? 0)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    chosenPark = campgroundsArray[indexPath.row]
    
    performSegue(withIdentifier: "campgroundDetails", sender: Any?.self)
  }
  
}
