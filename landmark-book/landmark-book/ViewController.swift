//
//  ViewController.swift
//  landmark-book
//
//  Created by Risetime on 10.12.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var landmarkNames = [String]()
    var landmarkImages = [UIImage()]
    var selectedName = ""
    var selectedImage = UIImage()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        landmarkNames.append("Colleseum")
        landmarkImages.append(UIImage(named: "colleseum.jpeg")!)
        
        landmarkNames.append("Eiffel")
        landmarkImages.append(UIImage(named: "eiffel.jpeg")!)
        
        landmarkNames.append("Kremlin")
        landmarkImages.append(UIImage(named: "kremlin.jpeg")!)
        
        landmarkNames.append("Stonehenge")
        landmarkImages.append(UIImage(named: "stonehenge.jpeg")!)
        
        landmarkNames.append("Taj Mahal")
        landmarkImages.append(UIImage(named: "tacmahal.jpeg")!)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarkNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = landmarkNames[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedName = landmarkNames[indexPath.row]
        selectedImage = landmarkImages[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCell.EditingStyle.delete){
            landmarkNames.remove(at: indexPath.row)
            landmarkImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toDetailsVC"){
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.selectedLandmarkName = selectedName
            destinationVC.selectedLandmarkImage = selectedImage
        }
    }

 
    
}


