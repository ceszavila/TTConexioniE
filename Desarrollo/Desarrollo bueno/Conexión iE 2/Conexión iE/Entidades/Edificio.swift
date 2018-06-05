//
//  Edificio.swift
//  Conexión iE
//
//  Created by Cesar Avila on 28/10/17.
//  Copyright © 2017 Cesar Avila. All rights reserved.
//

import UIKit

class Edificio: NSObject {
    // ATRIBUTOS DEL OBJETO EDIFICIO
    var numeroEdificio : String!
    var nombreEdificio : String!
    var nivelEdificio : Int!
    var serviciosEdificio : [UIImage]!
    var tipoEdificio : [UIImage]!
    var oficinasEdificio : [String]!
    
    // CONSTRUCTOR QUE INICIALIZA LOS ATRIBUTOS DEL OBJETO SALÓN
    
    init(numeroEdificio:String,nombreEdificio:String,nivelEdificio:Int, servicioEdificio:[UIImage],tipoEdificio:[UIImage],oficinasEdificio:[String]){
        self.numeroEdificio = numeroEdificio
        self.nombreEdificio = nombreEdificio
        self.nivelEdificio = nivelEdificio
        self.serviciosEdificio = servicioEdificio
        self.tipoEdificio = tipoEdificio
        self.oficinasEdificio = oficinasEdificio
        
    }
    
}

