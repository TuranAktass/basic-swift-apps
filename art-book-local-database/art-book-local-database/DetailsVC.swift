//
//  DetailsVC.swift
//  art-book-local-database
//
//  Created by Risetime on 11.12.2022.
//

import UIKit
import CoreData

class DetailsVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var artistField: UITextField!
    
    var selectedPaintingID : UUID?
    var selectedPainting : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedPainting != "" {
            //get from core data
            getData()
            
        } else {
            //Gesture Recognizer
            imageView.image = UIImage(named: "select_image")
            let gestureDetector = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(gestureDetector)
     
            imageView.isUserInteractionEnabled = true
            let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
            imageView.addGestureRecognizer(imageTapRecognizer)
        }
    
       
    }
    
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func saveClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        newPainting.setValue(nameField.text, forKey: "name")
        newPainting.setValue(artistField.text, forKey: "artist")
        
        if let year = Int(yearField.text!){
            newPainting.setValue(year, forKey: "year")
        }
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("success")
        } catch{
            print("Error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let uuidString = selectedPaintingID?.uuidString
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString!)
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0{
                for  result in results as! [NSManagedObject]{
                    if let name = result.value(forKey: "name") as? String{
                        nameField.text = name
                        nameField.endEditing(true)
                    }
                    
                    if let year = result.value(forKey: "year") as? Int{
                        yearField.text = String(year)
                    }
                    
                    if let artist = result.value(forKey: "artist") as? String{
                        artistField.text = artist
                    }
                    if let imageData = result.value(forKey: "image") as? Data{
                        imageView.image = UIImage(data: imageData)
                    }
                }
            }
        } catch {
            print("ERROR")
        }
       
   
    }

}
