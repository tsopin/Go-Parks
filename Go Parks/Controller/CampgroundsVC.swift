//
//  CampgroundsVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-08-22.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit

class CampgroundsVC: UIViewController {

  @IBOutlet weak var infoTextView: UITextView!
  var recievedPark : [CampgroundData]?
  
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
   override func viewWillAppear(_ animated: Bool) {
    
    infoTextView.text = recievedPark![0].name
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
