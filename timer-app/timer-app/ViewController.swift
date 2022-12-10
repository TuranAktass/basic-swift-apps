//
//  ViewController.swift
//  timer-app
//
//  Created by Risetime on 9.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var counter = 10
    var isTicking = false
    
    @IBOutlet weak var counterField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
   
    @IBAction func onChanged(_ sender: Any) {
        timeLabel.text = counterField.text
    }
    
    @IBAction func stopClicked(_ sender: Any) {
        isTicking = false
        timeLabel.text = "Time: \(counter)";
        timer = Timer()
    }
    
    @IBAction func startClicked(_ sender: Any) {
        isTicking = true
        counter = Int(counterField.text!) ?? 0
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        timeLabel.text = "Time: \(counter)"
       
        
    }
    
    @IBAction func restartClicked(_ sender: Any) {
        isTicking = true
        counter = Int(counterField.text!) ?? 0
        timeLabel.text = "Time: \(counter)"
        
    }
    
    @objc func timerFunction() {
        if(isTicking == true){
            if(counter <= 0){
                timeLabel.text = "Time Over"
            } else {
                print("tick tick")
                timeLabel.text = "Time: \(counter)";
                counter -= 1
            }
            
        } else {
            
            print("no tick no tock")
        }
        
    }
    
    
}

