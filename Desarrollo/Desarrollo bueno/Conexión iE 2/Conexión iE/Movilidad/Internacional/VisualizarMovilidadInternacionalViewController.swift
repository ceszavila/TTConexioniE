//
//  VisualizarMovilidadInternacionalViewController.swift
//  Conexión iE
//
//  Created by Cesar Avila on 24/05/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase

class VisualizarMovilidadInternacionalViewController: UIViewController {
    @IBOutlet weak var tituloMovilidad: UILabel!
    
    var movilidadInternacional : MovilidadInternacional!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tituloMovilidadInternacional : String = "Movilidad \(movilidadInternacional.periodo!) \(movilidadInternacional.ano!)"
        
        tituloMovilidad.text = tituloMovilidadInternacional
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //NOS ASEGURAMOS QUE SI SEA EL SEGUE QUE QUEREMOS CON E IDENTIFICADOR QUE LE PUSIMOS AL SEGUE
        switch segue.identifier{
        case "convocatoriaInternacional"?:
            let convocatoria = self.movilidadInternacional
            let destinationViewController = segue.destination as! ConvocatoriaInternacionalViewController
            destinationViewController.movilidadInternacional = convocatoria
            
        case "univerisdadInternacional"?:
            let convocatoria = self.movilidadInternacional
            let destinationViewController = segue.destination as! UniversidadInternacionalViewController
            destinationViewController.movilidadInternacional = convocatoria
            
        case "resultadoInternacional"?:
            let convocatoria = self.movilidadInternacional
            let destinationViewController = segue.destination as! ResultadoInternacionalViewController
            destinationViewController.movilidadInternacional = convocatoria
        default:
            break
        }
    }
}
