//
//  MovilidadInternacional.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 16/05/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import Foundation
import UIKit

class MovilidadInternacional : NSObject{
    
    //ATRIBUTOS DE LA CALSE MOVILIDAD INTERNACIONAL
    var idInternacional : String!
    var periodo : String!
    var ano : String!
    var universidad : String!
    var convocatoria : String!
    var resultados : String!

    // CONSTRUCTOR QUE SOLO INICIALIZA EL NOMBRE DE LA MOVILIDAD
    init(idInternacional:String,periodo:String,ano:String,universidad:String,convocatoria:String,resultados:String){
        self.idInternacional = idInternacional
        self.ano = ano
        self.universidad = universidad
        self.convocatoria = convocatoria
        self.resultados = resultados
        self.periodo = periodo
    }
}


