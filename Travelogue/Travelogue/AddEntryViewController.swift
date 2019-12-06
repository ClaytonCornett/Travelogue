//
//  AddEntryViewController.swift
//  Travelogue
//
//  Created by Clayton Cornett on 12/4/19.
//  Copyright © 2019 Clayton Cornett. All rights reserved.
//

import UIKit

class AddEntryViewController: UIViewController {

    @IBOutlet weak var entryImageView: UIImageView!
    
    var entry: Entry?
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var dateLabel: UILabel!
    var image: UIImage?
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addImage(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        
        
        let alert = UIAlertController(title: "Choose Image Options", message: "Use your camera or access your photo library?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
                self.present(picker, animated: true)
            }
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                picker.sourceType = .photoLibrary
                self.present(picker, animated: true)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        entryImageView.image = selectedImage
        
        if let entry = entry{
            entry.image = selectedImage
        }
        
        
        
    }
    
    
    @IBAction func saveEntry(_ sender: Any) {
        
        guard let title = titleTextField.text?.trimmingCharacters(in: .whitespaces), !title.isEmpty else {
            //alertNotifyUser(message: "Please enter a title before saving the note.")
            return
        }
        
        // if an existing note, update it
        // otherwise, create a new note
        if let entry = entry {
            entry.title = title
            entry.body = descriptionTextField.text
            entry.image = image
            // addDate is set when the Note is initialized
            // for existing note, the addDate stays the same as initially set
        } else {
            //entry = Entry(title: title, body: bodyTextView.text, image: image)
            entry = Entry(title: title, body: descriptionTextField.text, image: image)
        }
        
        // If a note exists, save it.
        if let entry = entry {
            do {
                let managedContext = entry.managedObjectContext
                try managedContext?.save()
            } catch {
                //alertNotifyUser(message: "The note could not be saved.")
            }
            
        } else {
            //alertNotifyUser(message: "The note could not be created.")
        }
        
        // Return to list of Notes.
        navigationController?.popViewController(animated: true)
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
