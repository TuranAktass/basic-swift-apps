//
//  DetailsVC.swift
//  simpson-book
//
//  Created by Risetime on 11.12.2022.
//

import UIKit

class DetailsVC: UIViewController {
    
    var simpson = Simpson(name: "", job: "", imageName: "")
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = UIImage(named: simpson.imageName)
        nameLabel.text = simpson.name
        jobLabel.text = simpson.job
    }
    

  

}
