//
//  Curso.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 20/05/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import Foundation
import UIKit

class Curso: NSObject {
    var idCurso : String!
    var nombreCurso : String!
    var descripcionCurso : String!
    var requisitosCurso : String!
    var fechaInicioCurso: String!
    var fechaFinCurso: String!
    var costoCurso : String!
    var costoIPNCurso : String!
    var urlCurso : String!
    
    init(idCurso:String, nombreCurso:String, descripcionCurso:String, requisitosCurso: String, fechaInicioCurso:String, fechaFinCurso:String, costoCurso:String, costoIPNCurso:String, urlCurso:String){
        self.idCurso = idCurso
        self.nombreCurso = nombreCurso
        self.descripcionCurso = descripcionCurso
        self.requisitosCurso = requisitosCurso
        self.fechaInicioCurso = fechaInicioCurso
        self.fechaFinCurso = fechaFinCurso
        self.costoCurso = costoCurso
        self.costoIPNCurso = costoIPNCurso
        self.urlCurso = urlCurso
    }
}
