//
//  ViewController.swift
//  FirstApp
//
//  Created by Risetime on 5.12.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
  
    @IBAction func buttonClicked(_ sender: Any) {
        imageView.image = UIImage(named: "metallica2")

    }
}
