//
//  CryptoTableViewCell.swift
//  CryptoMvvm
//
//  Created by Turan Aktaş on 4.02.2023.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {

    @IBOutlet weak var currenyName: UILabel!
    @IBOutlet weak var currencyPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

