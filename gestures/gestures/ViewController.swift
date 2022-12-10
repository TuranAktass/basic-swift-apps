//
//  ViewController.swift
//  gestures
//
//  Created by Risetime on 9.12.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    var imageList = ["metallica", "metallica2"]
    var selectedImageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView.isUserInteractionEnabled = true
        let gestureDetector = UITapGestureRecognizer(target: self, action: #selector(changePic))

        imageView.addGestureRecognizer(gestureDetector)
    }
    
    @objc func changePic() {
        if(selectedImageIndex >= imageList.count - 1){
            selectedImageIndex = 0
        } else {
            selectedImageIndex = selectedImageIndex + 1
        }
        
        print(selectedImageIndex)
        imageView.image = UIImage(named: imageList[selectedImageIndex])
    }


}

