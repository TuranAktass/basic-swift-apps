//
//  View.swift
//  viper-crypto
//
//  Created by Turan Aktaş on 6.02.2023.
//

import Foundation
import UIKit


protocol AnyView{
    var presenter : AnyPresenter? {get set}
    
    func update(with cryptos : [Crypto])
    func update(with error : NetworkError)
}

class CryptoView : UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource{
    
    
    var cryptos : [Crypto] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = cryptos[indexPath.row].currency
        content.secondaryText = cryptos[indexPath.row].price
        cell.contentConfiguration = content
        cell.backgroundColor = .green
        return cell

    }
    
    var presenter: AnyPresenter?
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        return tableView
        
    }()
    
    private let messageLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading..."
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .yellow
        view.addSubview(tableView)
        view.addSubview(messageLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: Int(view.frame.width) / 2 - 100, y: Int(view.frame.height) / 2 - 25, width: 200, height: 25)
     
    }
    
    
    
    
    
    func update(with cryptos: [Crypto]) {
        DispatchQueue.main.async {
            self.cryptos = cryptos
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: NetworkError) {
        self.cryptos = []
        self.tableView.isHidden = true
        messageLabel.text = "Error"

        self.messageLabel.isHidden = false
    }
    
    
}
