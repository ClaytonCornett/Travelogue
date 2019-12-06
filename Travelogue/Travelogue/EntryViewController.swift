//
//  EntryViewController.swift
//  Travelogue
//
//  Created by Clayton Cornett on 12/4/19.
//  Copyright © 2019 Clayton Cornett. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    @IBOutlet weak var tripEntryImageView: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var entry: Entry?
    var trip: Trip?
    
    var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateFormat = "MMM d, yyyy"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.title = entry?.title
        
        tripEntryImageView.image = entry?.image
        titleLabel.text = entry?.title
        
        descriptionLabel.text = entry?.body
    
        
//        if let date = entry?.rawAddDate {
//            dateLabel.text = dateFormatter.string(from: date)
//        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? AddEntryViewController else {
            return
        }
        
        //destination.trip = trip
       // destination.entry = entry
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
