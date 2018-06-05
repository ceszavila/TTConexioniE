//
//  ViewControllerTableViewCell.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 24/03/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {
    @IBOutlet weak var lblNombreProfesor: UILabel!
    @IBOutlet weak var fotoProfesor: UIImageView!
    
    @IBOutlet weak var lblCubiculoProfesor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
