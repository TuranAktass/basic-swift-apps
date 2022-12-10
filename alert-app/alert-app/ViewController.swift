//
//  ViewController.swift
//  alert-app
//
//  Created by Risetime on 9.12.2022.
//

import UIKit

class ViewController: UIViewController {

 

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordAgainField: UITextField!
    
    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
        (UIAlertAction) in
            print("OK clicked")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signUpClicked(_ sender: Any) {
        
        print("clicked")
        
        if(nameField.text!.isEmpty || passwordField.text!.isEmpty || passwordAgainField.text!.isEmpty){
            createAlert(title: "Error", message: "Required Fields Are Empty")
        } else if(passwordField.text! != passwordAgainField.text){
            createAlert(title: "Error", message: "Password and repeat password should be the same")
        } else {
            performSegue(withIdentifier: "toHomePage", sender: nil)
        }
        
    }
    
    func createAlert(title:String ,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

