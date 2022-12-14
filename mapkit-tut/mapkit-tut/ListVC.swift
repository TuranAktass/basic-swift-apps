//
//  ListVC.swift
//  mapkit-tut
//
//  Created by Risetime on 14.12.2022.
//

import UIKit
import CoreData

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var listView: UITableView!
    var locations = [LocationModel]()
    var selectedLocation : LocationModel?
    
    override func viewDidLoad() {
        getData()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toAddView))
        
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
        listView.delegate = self
        listView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLocation = locations[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = locations[indexPath.row].name
        content.secondaryText = locations[indexPath.row].note
        cell.contentConfiguration = content
        
        return cell
    }
    
    @objc func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        locations.removeAll(keepingCapacity: false)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LocationEntity")
        fetchRequest.returnsObjectsAsFaults = false
        
        
        do{
            let results = try context.fetch(fetchRequest) as! [LocationEntity]
            for  location in results {
                //context.delete(location)
                    locations.append(LocationModel(locationEntity: location))
                    self.listView.reloadData()
               
            }
            
        } catch {
            print("error")
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destination = segue.destination as! ViewController
            destination.selectedLocation = selectedLocation
        }
        
    }
    
    @objc func toAddView() {
        selectedLocation = nil
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    
    

}
