//
//  DetailsViewController.swift
//  landmark-book
//
//  Created by Risetime on 10.12.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var landmarkLabel: UILabel!
    @IBOutlet weak var landmarkImage: UIImageView!
    
    var selectedLandmarkName = ""
    var selectedLandmarkImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        landmarkLabel.text = selectedLandmarkName
        landmarkImage.image = selectedLandmarkImage
        // Do any additional setup after loading the view.
    }
    

}
