//
//  CreateTripViewController.swift
//  Travelogue
//
//  Created by Clayton Cornett on 12/4/19.
//  Copyright © 2019 Clayton Cornett. All rights reserved.
//

import UIKit

class CreateTripViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBAction func createTrip(_ sender: Any) {
        
        let title = titleTextField.text
        
        let tripTitle = Trip(name: title)
        
        do {
            try tripTitle?.managedObjectContext?.save()
            
            self.navigationController?.popViewController(animated: true)
        } catch {
            print("Error")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
