//
//  EntryTableViewController.swift
//  Travelogue
//
//  Created by Clayton Cornett on 12/4/19.
//  Copyright © 2019 Clayton Cornett. All rights reserved.
//

import UIKit

class EntryTableViewController: UITableViewController {

    @IBOutlet var entryTableView: UITableView!
    var selectedTrip: Trip?
    var dateFormatter = DateFormatter()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        
        //self.title = selectedTrip!.name
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            //fetchEntries()
        //tripsTableView.reloadInputViews()
        entryTableView.reloadData()
        
    }
    
//    func fetchEntries() {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            selectedTrip = [Trip]()
//            return
//        }
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
//        //fetchRequest.sortDescriptors = [NSSortDescriptor(key: "rawAddDate", ascending: true)]
//
//        do {
//            selectedTrips = try managedContext.fetch(fetchRequest)
//        } catch {
//            alertNotifyUser(message: "Fetch for trips failed.")
//        }
//    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedTrip?.tripEntries?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryTableCell", for: indexPath)
        
        if let tripEntry = selectedTrip?.tripEntries?[indexPath.row], let  cell = cell as? EntryTableViewCell{
            
            
            cell.textLabel?.text = tripEntry.title
            //cell.entryImage.image = tripEntry.image
            //needs date
            
        }
        
        
        
        //let trip = trips[indexPath.row]
        
        //        if let addDate = trip.addDate {
        //            cell.detailTextLabel?.text = dateFormatter.string(from: addDate)
        //        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            //self.deleteNote(indexPath: indexPath)
        }
        
        return [deleteAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.destination is CreateTripViewController else {
            return
        }
        
        
        
        // if let segueIdentifier = segue.identifier, segueIdentifier == "trip", let //indexPathForSelectedRow = tripsTableView.indexPathForSelectedRow {
        //destination.trip = trips[indexPathForSelectedRow.row]
        //}
    }
    
//    func fetchTrips() {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            trips = [Trip]()
//            return
//        }
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
//        //fetchRequest.sortDescriptors = [NSSortDescriptor(key: "rawAddDate", ascending: true)]
//
//        do {
//            trips = try managedContext.fetch(fetchRequest)
//        } catch {
//            alertNotifyUser(message: "Fetch for trips failed.")
//        }
//    }
    
//    func deleteNote(indexPath: IndexPath) {
//        let trip = trips[indexPath.row]
//
//        if let managedObjectContext = trip.managedObjectContext {
//            managedObjectContext.delete(trip)
//
//            do {
//                try managedObjectContext.save()
//                self.trips.remove(at: indexPath.row)
//                //tripsTableView.reloadInputViews()
//            } catch {
//                alertNotifyUser(message: "Delete failed.")
//                //tripsTableView.reloadInputViews()
//            }
//        }
//    }
    
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
