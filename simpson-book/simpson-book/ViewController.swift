//
//  ViewController.swift
//  simpson-book
//
//  Created by Risetime on 11.12.2022.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
     let simpsonsList = [Simpson(name: "Bart", job: "No Job", imageName: "bart.png"), Simpson(name: "Homer", job: "No Job", imageName: "homer.jpeg"), Simpson(name: "Marge", job: "No Jon", imageName: "marge.png"), Simpson(name: "Lisa", job: "No Job", imageName: "lisa.png")]
    
    var selectedSimpson : Simpson?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var content = cell.defaultContentConfiguration()
            content.text = simpsonsList[indexPath.row].name
            cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        simpsonsList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSimpson = simpsonsList[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toDetailsVC"){
            let detailsVC = segue.destination as! DetailsVC
            detailsVC.simpson = selectedSimpson!
        }
    }
    
    

}

