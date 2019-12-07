//
//  TripTableViewController.swift
//  Travelogue
//
//  Created by Clayton Cornett on 12/4/19.
//  Copyright © 2019 Clayton Cornett. All rights reserved.
//

import UIKit
import CoreData

class TripTableViewController: UITableViewController {
    
    @IBOutlet var tripsTableView: UITableView!
    //@IBOutlet weak var tripsTableView: UIView!
    var trips = [Trip]()
    var dateFormatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchTrips()
        //tripsTableView.reloadInputViews()
        tripsTableView.reloadData()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripTableCell", for: indexPath)
        
        let trip = trips[indexPath.row]
        cell.textLabel?.text = trip.name
//        if let addDate = trip.addDate {
//            cell.detailTextLabel?.text = dateFormatter.string(from: addDate)
//        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            self.deleteNote(indexPath: indexPath)
        }
        
        return [deleteAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? CreateTripViewController else {
            return
        }

       // if let segueIdentifier = segue.identifier, segueIdentifier == "trip", let //indexPathForSelectedRow = tripsTableView.indexPathForSelectedRow {
            //destination.trip = trips[indexPathForSelectedRow.row]
        //}
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let destination = segue.destination as? EntryTableViewController,
//            let selectedRow = self.tripsTableView.indexPathForSelectedRow?.row else {
//                return
//        }
//        destination.selectedTrip = trips[selectedRow]
//    }
    
    func fetchTrips() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            trips = [Trip]()
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        //fetchRequest.sortDescriptors = [NSSortDescriptor(key: "rawAddDate", ascending: true)]
        
        do {
            trips = try managedContext.fetch(fetchRequest)
        } catch {
            alertNotifyUser(message: "Fetch for trips failed.")
        }
    }
    
    func deleteNote(indexPath: IndexPath) {
        let trip = trips[indexPath.row]
        
        if let managedObjectContext = trip.managedObjectContext {
            managedObjectContext.delete(trip)
            
            do {
                try managedObjectContext.save()
                self.trips.remove(at: indexPath.row)
                //tripsTableView.reloadInputViews()
            } catch {
                alertNotifyUser(message: "Delete failed.")
                //tripsTableView.reloadInputViews()
            }
        }
    }
    
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
