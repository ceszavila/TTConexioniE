//
//  UnidadDeAprendizaje.swift
//  Conexión iE
//
//  Created by Cesar Avila on 07/10/17.
//  Copyright © 2017 Cesar Avila. All rights reserved.
//
import Foundation
import UIKit

class UnidadDeAprendizaje: NSObject {
    
    // ATRIBUTOS DE LA CLASE UNIDAD DE APRENDIZAJE
    var nombreUA : String!
    var tipo : String!
    var programaAcademico : String!
    var academia : String
    var profesor : Profesor!
    
    // Constructor que solo inicializa el nombre de la Unidad de Aprendizaje
    
    init(nombreUA:String,tipo:String,programaAcademico:String,academia:String,profesor:Profesor){
            self.nombreUA = nombreUA
            self.tipo = tipo
            self.programaAcademico = programaAcademico
            self.academia = academia
            self.profesor = profesor
        }
}
