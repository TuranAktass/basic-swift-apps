//
//  ViewController.swift
//  api
//
//  Created by Risetime on 14.12.2022.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    var movies = [Movie]()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        getData()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = movies[indexPath.row].title
        content.secondaryText = String(movies[indexPath.row].year!)
        cell.contentConfiguration = content
        
        return cell
    }
    
    
    func getData() {
        
        let url = URL(string: "http://www.omdbapi.com/?apikey=cebce6&s=batman")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                self.createAlert(title: "error", message: "something went wrong")
            } else {
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            let response = jsonResponse["Search"] as! [Dictionary<String, Any>]
                            for movie in response {
                                self.movies.append(Movie(dict: movie))
                                self.tableView.reloadData()
                            }
                        }
                    } catch {
                        print("error")
                    }
                }
                
            }}
        
        task.resume()
   
        
        }
    
    func createAlert(title:String ,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    }


