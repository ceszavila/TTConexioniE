//
//  VisualizarMovilidadViewController.swift
//  Conexión iE
//
//  Created by Cesar Avila on 24/05/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase
import WebKit

class VisualizarMovilidadViewController: UIViewController {

    @IBOutlet weak var tituloNacional: UILabel!
    @IBOutlet weak var seleccion: UISegmentedControl!
    @IBOutlet weak var navegadorWeb: WKWebView!
    
    var movilidadNacional : MovilidadNacional!
    var direccion : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
       let  tituloMovilidadNacional : String = "Movilidad \(movilidadNacional.periodoN!) \(movilidadNacional.anoN!)"
        tituloNacional.text = tituloMovilidadNacional
       
        // Do any additional setup after loading the view.
    }


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //NOS ASEGURAMOS QUE SI SEA EL SEGUE QUE QUEREMOS CON E IDENTIFICADOR QUE LE PUSIMOS AL SEGUE
        switch segue.identifier{
        case "convocatoriaNacional"?:
            let convocatoria = self.movilidadNacional
            let destinationViewController = segue.destination as! ConvocatoriaNacionalViewController
            destinationViewController.movilidadNacional = convocatoria
            
        case "universidadNacional"?:
            let convocatoria = self.movilidadNacional
            let destinationViewController = segue.destination as! UniversidadNacionalViewController
            destinationViewController.movilidadNacional = convocatoria
            
        case "resultadoNacional"?:
            let convocatoria = self.movilidadNacional
            let destinationViewController = segue.destination as! ResultadoNacionalViewController
            destinationViewController.movilidadNacional = convocatoria
        default:
            break
        }
    }

}
