//
//  ViewController.swift
//  art-book-local-database
//
//  Created by Risetime on 11.12.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var nameArray = [String]()
    var idArray = [UUID]()
    var selectedPaintings = ""
    var selectedID : UUID?
    
    override func viewDidLoad() {
        
        getData()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButtonClicked))
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = nameArray[indexPath.row]
        cell.contentConfiguration = content
    
        return cell
        
      
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedID = idArray[indexPath.row]
        selectedPaintings = nameArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toDetailsVC"){
            let destination = segue.destination as! DetailsVC
            destination.selectedPainting = selectedPaintings
            destination.selectedPaintingID = selectedID
            
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCell.EditingStyle.delete){
            deleteData(uuid: idArray[indexPath.row].uuidString)
            nameArray.remove(at: indexPath.row)
            idArray.remove(at: indexPath.row)
            self.tableView.reloadData()
       
        }
    }
  
    
    @objc func onAddButtonClicked() {
        selectedPaintings = ""
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    @objc func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results =  try context.fetch(fetchRequest)
            nameArray.removeAll(keepingCapacity: false)
            idArray.removeAll(keepingCapacity: false)
            for result in results as! [NSManagedObject]{
                if let name = result.value(forKey: "name") as? String{
                    self.nameArray.append(name)
                }
                
                if let id = result.value(forKey: "id") as? UUID{
                    self.idArray.append(id)
                }
                  
                self.tableView.reloadData()
            }
            
        } catch {
            print("Error")
        }
    }
    
    func deleteData(uuid : String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.predicate = NSPredicate(format: "id = %@", uuid)
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let data = try context.fetch(fetchRequest)
            if data.count > 0  {
                for item in data as! [NSManagedObject] {
                    if let id = item.value(forKey: "id") as? UUID{
                        if(id.uuidString == uuid) {
                            print("entered for delete")
                            context.delete(item)
                       
                            
                            do {try context.save()} catch{print("error")}
                        }
                    }
                }
               
            }
            
        } catch{
            print("ERROR")
        }
        
       
    }

}

