//
//  ViewController.swift
//  segueAPp
//
//  Created by Risetime on 9.12.2022.
//

import UIKit

class ViewController: UIViewController {
    var username = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var nameField: UITextField!
    
    @IBAction func nextClicked(_ sender: Any) {
        username = nameField.text!
        performSegue(withIdentifier: "toSecondPage", sender: username)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondPage"{
            let destination = segue.destination as! SecondViewController
            destination.name = username
        }
    }
}

