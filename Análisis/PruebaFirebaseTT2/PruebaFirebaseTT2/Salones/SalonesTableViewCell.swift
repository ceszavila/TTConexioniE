//
//  SalonesTableViewCell.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 26/03/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit

class SalonesTableViewCell: UITableViewCell {
    @IBOutlet weak var nombreSalon: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func editarSalon(_ sender: Any) {
    }
    
}
