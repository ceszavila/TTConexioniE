//
//  Profesor.swift
//  Conexión iE
//
//  Created by Cesar Avila on 07/10/17.
//  Copyright © 2017 Cesar Avila. All rights reserved.
//

import Foundation
import UIKit

class Profesor: NSObject {
    // ATRIBUTOS DE LA CLASE PROFESOR
    var nombre : String!
    var fotografia : UIImage!
    var cubiculo : String!
    var email : String!
    var telefono : String!
    var paginaWeb : String?
    var horarioAtencion : [String]!
    
    // var rating : String = ""
    
    // CONSTRUCTORS DONDE SOLO SE INICIA EL NOMBRE DEL PROFESOR
    init(nombre:String,fotografia:UIImage, cubiculo:String,email:String,telefono:String,paginaWeb:String,horarioAtencion:[String]){
        self.nombre = nombre
        self.fotografia = fotografia
        self.cubiculo = cubiculo
        self.email = email
        self.telefono = telefono
        self.paginaWeb = paginaWeb
        self.horarioAtencion = horarioAtencion
    }
    
}
