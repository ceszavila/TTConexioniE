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
    var idProf : String!
    var nombre : String!
    var fotografia : String!
    var cubiculo : String!
    var email : String!
    var telefono : String!
    var paginaWeb : String?
    var horarioAtencion : String!
    var academia : String!
    var materias : String!
    var trabajoTerminal : String!
    
    // var rating : String = ""
    
    // CONSTRUCTORS DONDE SOLO SE INICIA EL NOMBRE DEL PROFESOR
    init(idProf:String,nombre:String,fotografia:String, cubiculo:String,email:String,telefono:String,paginaWeb:String,horarioAtencion:String,academia:String,materias:String,trabajoTerminal:String){
        self.idProf = idProf
        self.nombre = nombre
        self.fotografia = fotografia
        self.cubiculo = cubiculo
        self.email = email
        self.telefono = telefono
        self.paginaWeb = paginaWeb
        self.horarioAtencion = horarioAtencion
        self.academia = academia
        self.materias = materias
        self.trabajoTerminal = trabajoTerminal
    }
    
}
