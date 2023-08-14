//
//  ActiviteslistViewController.swift
//  Calories Calculator
//
//  Created by Mykhailo Zagiko on 14.08.2023.
//

import UIKit

class ActivitesListViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var activity: Activity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let activity = activity {
            label.text = "Activity: \(activity.title) with \(activity.value) calories"
        } else {
            label.text = "No selected activity"
        }

    }
    


}
