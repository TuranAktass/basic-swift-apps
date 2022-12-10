//
//  ViewController.swift
//  birthdate-note-keeper
//
//  Created by Risetime on 8.12.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let storedName = UserDefaults.standard.object(forKey: "Name")
        let storedBirthday = UserDefaults.standard.object(forKey: "Birthday")
        
        
        if let myName = storedName as? String {
            nameLabel.text = myName

        }
        
        if let myBd = storedBirthday as? String {
            birthdayLabel.text = myBd
        }
      
    }


    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var birthdayField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var birthdayLabel: UILabel!
    
    @IBAction func save(_ sender: Any) {
        UserDefaults.standard.set(nameField.text, forKey: "Name")
        UserDefaults.standard.set(birthdayField.text, forKey: "Birthday")
        viewDidLoad()

    }
    
    @IBAction func deleteSavedData(_ sender: Any) {
        
        let storedName = UserDefaults.standard.object(forKey: "Name")
        let storedBd = UserDefaults.standard.object(forKey: "Birthday")
        
        if(storedName as? String ) != nil {
            UserDefaults.standard.removeObject(forKey: "Name")
            nameLabel.text = "Name: "
        }
        
        if(storedBd as? String) != nil {
            UserDefaults.standard.removeObject(forKey: "Birthday")
            birthdayLabel.text = "Birthday: "
        }
    
    }
}

