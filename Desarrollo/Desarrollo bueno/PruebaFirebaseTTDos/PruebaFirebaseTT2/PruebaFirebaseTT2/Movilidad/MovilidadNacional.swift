//
//  MovilidadNacional.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 16/05/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//


import Foundation
import UIKit

class MovilidadNacional : NSObject{
    
    //ATRIBUTOS DE LA CALSE MOVILIDAD INTERNACIONAL
    var idNacional : String!
    var periodoN : String!
    var anoN : String!
    var universidadN : String!
    var convocatoriaN : String!
    var resultadosN : String!
    
    // CONSTRUCTOR QUE SOLO INICIALIZA EL NOMBRE DE LA MOVILIDAD
    init(idNacional:String,periodoN:String,anoN:String,universidadN:String,convocatoriaN:String,resultadosN:String){
        self.idNacional = idNacional
        self.periodoN = periodoN
        self.anoN = anoN
        self.universidadN = universidadN
        self.convocatoriaN = convocatoriaN
        self.resultadosN = resultadosN
    }
}



