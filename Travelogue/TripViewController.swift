//
//  TripViewController.swift
//  Travelogue
//
//  Created by Clayton Cornett on 12/3/19.
//  Copyright © 2019 Clayton Cornett. All rights reserved.
//

import UIKit
import CoreData

class TripViewController: UIViewController, UITableViewDataSource, UITableviewDelegate {

    var trips = [Trip]()
    var dateFormatter = DateFormatter()
   // @IBOutlet weak var tripsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchTrips()
        tripsTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
        
        let trip = trips[indexPath.row]
        cell.textLabel?.text = trip.title
        if let addDate = trip.addDate {
            cell.detailTextLabel?.text = dateFormatter.string(from: addDate)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            self.deleteNote(indexPath: indexPath)
        }
        
        return [deleteAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? TripDetailTableViewController else {
            return
        }
        
        if let segueIdentifier = segue.identifier, segueIdentifier == "trip", let indexPathForSelectedRow = notesTableView.indexPathForSelectedRow {
            destination.note = notes[indexPathForSelectedRow.row]
        }
    }
    
    func fetchTrips() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            notes = [Note]()
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "rawAddDate", ascending: true)]
        
        do {
            notes = try managedContext.fetch(fetchRequest)
        } catch {
            alertNotifyUser(message: "Fetch for notes failed.")
        }
    }
    
    func deleteNote(indexPath: IndexPath) {
        let trip = trips[indexPath.row]
        
        if let managedObjectContext = trip.managedObjectContext {
            managedObjectContext.delete(note)
            
            do {
                try managedObjectContext.save()
                self.trips.remove(at: indexPath.row)
                tripsTableView.reloadData()
            } catch {
                alertNotifyUser(message: "Delete failed.")
                tripsTableView.reloadData()
            }
        }
    }
    
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
