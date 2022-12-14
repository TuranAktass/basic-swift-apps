//
//  ViewController.swift
//  face-recognition
//
//  Created by Risetime on 14.12.2022.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInClicked(_ sender: Any) {
        let localAuth = LAContext()
        
        var error : NSError?
        
        if localAuth.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            localAuth.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "is it you",  reply: {
                (isSuccess, error) in
                if  isSuccess {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toSignedIn", sender: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.label.text = "error"
                    }
                }
                
                
            })
        }
    }
    
}

