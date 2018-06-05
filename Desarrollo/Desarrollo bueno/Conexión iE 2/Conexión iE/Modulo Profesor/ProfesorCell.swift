//
//  ProfesorCell.swift
//  Conexión iE
//
//  Created by Cesar Avila on 08/10/17.
//  Copyright © 2017 Cesar Avila. All rights reserved.
//

import UIKit

class ProfesorCell: UITableViewCell {

    @IBOutlet weak var fotoProfesor: UIImageView!
    @IBOutlet weak var nombreProfesor: UILabel!
    @IBOutlet weak var cubiculoProfesor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
