//
//  EdificiosViewController.swift
//  Conexión iE
//
//  Created by Cesar Avila on 28/10/17.
//  Copyright © 2017 Cesar Avila. All rights reserved.
//

import UIKit

class EdificiosViewController: UIViewController {
    @IBOutlet weak var tituloEdificio: UILabel!
    @IBOutlet weak var idEdificio: UILabel!
    @IBOutlet weak var nombreEdificio: UILabel!
    @IBOutlet weak var nivelEdificio: UILabel!
    @IBOutlet weak var baños: UIImageView!
    @IBOutlet weak var escaleras: UIImageView!
    @IBOutlet weak var discapacidad: UIImageView!
    @IBOutlet weak var salon: UIImageView!
    @IBOutlet weak var laboratorioComputación: UIImageView!
    @IBOutlet weak var cubiculo: UIImageView!
    var edificios : [Edificio] = []
   // ESTA VARIABLE NOMBRE NOS SIRVE POR QUE CON ESA VARIABLE ESTAMOS TRAYENDO EL NOMBRE DEL EDIFIO SELECCIONADO EN DETALLESSALONVIEWCONTROLLER EN LA FUNCION PREPARE FOR SEGUE 
    var nombre = String()
    
    
    override func viewDidLoad() {
        var edificio = Edificio(numeroEdificio: nombre,
                                nombreEdificio: "Edificio \(nombre)",
                                nivelEdificio: 3,
                                servicioEdificio: [#imageLiteral(resourceName: "baños"),#imageLiteral(resourceName: "escaleras"),#imageLiteral(resourceName: "discapacidad")],
                                tipoEdificio: [#imageLiteral(resourceName: "salones"),#imageLiteral(resourceName: "laboratorio"),#imageLiteral(resourceName: "cubiculo")],
                                oficinasEdificio: ["Sala de Impreisones", "Servicio Médico", "Credenciales ESCOM"])
        edificios.append(edificio)
        
        super.viewDidLoad()
        /* EN ESTA PARTE DEL CODIGO ESTAMOS CREANDO LA VISTA DE DETALLES DEL PROFESOR, CON CADA UNO DE LOS LABELS E IMAGESVIEW QUE TENEMOS EN LA PANTALLA*/
        self.title = "Detalles Edificio"
        self.tituloEdificio.text = "Información del \(edificio.nombreEdificio!)"
        self.idEdificio.text = edificio.numeroEdificio
        self.nombreEdificio.text = edificio.nombreEdificio
        self.nivelEdificio.text = "\(edificio.nivelEdificio!)"
        switch nombre {
        case "1A":
            self.baños.image = edificio.serviciosEdificio[0]
            self.escaleras.image = edificio.serviciosEdificio[1]
            self.discapacidad.image = edificio.serviciosEdificio[2]
            self.salon.image = edificio.tipoEdificio[0]
            self.laboratorioComputación.image = edificio.tipoEdificio[1]
            self.cubiculo.image = edificio.tipoEdificio[2]
        case "1B":
            self.baños.image = edificio.serviciosEdificio[0]
            self.escaleras.image = edificio.serviciosEdificio[1]
            self.discapacidad.image = edificio.serviciosEdificio[2]
            self.salon.image = edificio.tipoEdificio[0]
            self.cubiculo.image = edificio.tipoEdificio[2]
        case "2A":
            self.baños.image = edificio.serviciosEdificio[0]
            self.escaleras.image = edificio.serviciosEdificio[1]
            self.discapacidad.image = edificio.serviciosEdificio[2]
            self.salon.image = edificio.tipoEdificio[0]
            self.laboratorioComputación.image = edificio.tipoEdificio[1]
            self.cubiculo.image = edificio.tipoEdificio[2]
        case "2B":
            self.baños.image = edificio.serviciosEdificio[0]
            self.escaleras.image = edificio.serviciosEdificio[1]
            self.discapacidad.image = edificio.serviciosEdificio[2]
            self.salon.image = edificio.tipoEdificio[0]
            self.laboratorioComputación.image = edificio.tipoEdificio[1]
            self.cubiculo.image = edificio.tipoEdificio[2]
        case "Central":
            self.escaleras.image = edificio.serviciosEdificio[1]
            self.discapacidad.image = edificio.serviciosEdificio[2]
            self.laboratorioComputación.image = edificio.tipoEdificio[1]
            self.cubiculo.image = edificio.tipoEdificio[2]
        default:
            break
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
