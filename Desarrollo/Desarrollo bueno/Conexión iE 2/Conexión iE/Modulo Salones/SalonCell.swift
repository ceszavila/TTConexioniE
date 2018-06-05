//
//  SalonCell.swift
//  Conexión iE
//
//  Created by Cesar Avila on 15/10/17.
//  Copyright © 2017 Cesar Avila. All rights reserved.
//

import UIKit

class SalonCell: UITableViewCell {

    @IBOutlet weak var nombreGrupo: UILabel!
    @IBOutlet weak var salonGrupo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
