//
//  Formulario.swift
//  Movilidad2
//
//  Created by Ivo Sam on 5/6/18.
//  Copyright © 2018 Ivo Sam. All rights reserved.
//


import UIKit

struct Formulario {
    var tipo : String
    var imagen : UIImage

    init(tipo : String) {
        self.tipo = tipo
        imagen = UIImage(named: self.tipo.lowercased())!
    }
}
