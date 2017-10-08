//
//  Salon.swift
//  Conexión iE
//
//  Created by Cesar Avila on 07/10/17.
//  Copyright © 2017 Cesar Avila. All rights reserved.
//
import Foundation
import UIKit

class Salon: NSObject {
    // ATRIBUTOS DE LA CLASE SALON
    var nombreSalon : String!
    var grupo : String!
    var edificio : Int!
    var nivel : Int!
    
    // CONSTRUCTOR QUE SOLO INICIALIZA EL NOMBRE DEL GRUPO
    init(nombreSalon:String,grupo:String,edificio:Int,nivel:Int){
        self.nombreSalon = nombreSalon
        self.grupo = grupo
        self.edificio = edificio
        self.nivel = nivel
    }
    
}
