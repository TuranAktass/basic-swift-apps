//
//  ViewController.swift
//  ui_with_code
//
//  Created by Risetime on 8.12.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let width = view.frame.size.width;
        let height = view.frame.size.height;
        
        let myLabel = UILabel()
        myLabel.text = "Text Text"
        myLabel.textAlignment = .center
        myLabel.textColor = UIColor(named: "red")
        myLabel.frame = CGRect(x: (width * 0.5) - (width * 0.5 - width * 0.8 / 2), y: height / 2, width: width * 0.8, height: 50)
        view.addSubview(myLabel)
        
        let myButton = UIButton()
        myButton.setTitle( "Button Butt", for: UIControl.State.normal)
        myButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        myButton.frame = CGRect(x: 100, y: 300, width: 100, height: 50)
        
        myButton.addTarget(self, action: #selector(ViewController.myAction), for: UIControl.Event.touchUpInside)
        view.addSubview(myButton)
    }
    
        
    
    @objc func myAction() {
        let myImage = UILabel()
        myImage.text = "Metallica"
        myImage.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        view.addSubview(myImage)
    }
    
  
}

