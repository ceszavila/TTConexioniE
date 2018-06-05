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
    var idSalon : String!
    var nombreSalon : String!
    var grupo : String!
    var numeroEdifico : String!
    var latitudSalon : String!
    var longitudSalon : String!
    var imagenNivel : String!
    var imagenSalon : String!
    
    // CONSTRUCTOR QUE SOLO INICIALIZA EL NOMBRE DEL GRUPO
    init(idSalon:String,nombreSalon:String,grupo:String,numeroEdificio:String,latitudSalon:String,longitudSalon:String,imagenNivel:String,imagenSalon:String){
        self.idSalon = idSalon
        self.nombreSalon = nombreSalon
        self.grupo = grupo
        self.numeroEdifico = numeroEdificio
        self.latitudSalon = latitudSalon
        self.longitudSalon = longitudSalon
        self.imagenNivel = imagenNivel
        self.imagenSalon = imagenSalon
    }
    
}
