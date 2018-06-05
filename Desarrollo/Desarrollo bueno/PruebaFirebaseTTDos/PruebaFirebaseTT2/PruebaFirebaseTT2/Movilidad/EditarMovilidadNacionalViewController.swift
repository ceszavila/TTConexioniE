//
//  EditarMovilidadNacionalViewController.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 19/05/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase

var refEditarNacional : DatabaseReference!

class EditarMovilidadNacionalViewController: UIViewController {
    var movilidadNacional : MovilidadNacional!
    
    @IBOutlet weak var anoNacional: UITextField!
    @IBOutlet weak var periodoNacional: UITextField!
    @IBOutlet weak var universidadNacional: UITextField!
    @IBOutlet weak var convocatoriaNacional: UITextField!
    @IBOutlet weak var resultadoNacional: UITextField!
    
    @IBOutlet weak var msjlbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        msjlbl.text = ""
        refEditarNacional = Database.database().reference().child("nacional");
        let idNacional = movilidadNacional.idNacional
        
        periodoNacional.text = movilidadNacional.periodoN!
        anoNacional.text = movilidadNacional.anoN!
        universidadNacional.text = movilidadNacional.universidadN!
        convocatoriaNacional.text = movilidadNacional.convocatoriaN!
        resultadoNacional.text = movilidadNacional.resultadosN!
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        //Descomentar, si el tap no debe interferir o cancelar otras acciones
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Las vistas y toda la jerarquía renuncia a responder, para esconder el teclado
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editarMovilidadNacional(_ sender: Any) {
        let idNacional = self.movilidadNacional.idNacional!
        
        let movilidadNacional = ["id_nacional" : idNacional,
                               "ano_nacional" : anoNacional.text! as String,
                               "periodo_nacional" : periodoNacional.text! as String,
                               "convocatoria_nacional" : convocatoriaNacional.text! as String,
                               "universidad_nacional" : universidadNacional.text! as String,
                               "resultado_nacional" : resultadoNacional.text! as String
        ]
        refEditarNacional.child(idNacional).setValue(movilidadNacional)
        msjlbl.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        msjlbl.text = "La movilidad nacional se editó exitosamente"
    }
    
    func borrarMovilidadNacional(idNacional:String){
        refEditarNacional.child(idNacional).setValue(nil)
        
        
    }
    
    @IBAction func eliminarMovilidadNacional(_ sender: Any) {
        let alertController = UIAlertController(title: " Esta seguro que desea eliminar la movilidad nacional \(movilidadNacional.periodoN!) \(movilidadNacional.anoN!)", message: "", preferredStyle: .alert)
        let eliminarMovilidadNacional = UIAlertAction(title: "Eliminar ", style: .destructive) { (_) in
            self.borrarMovilidadNacional(idNacional: self.movilidadNacional.idNacional)
        }
        let cancelarOperacion = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        alertController.addAction(eliminarMovilidadNacional)
        alertController.addAction(cancelarOperacion)
        present(alertController, animated: true, completion: nil)
        
        
    }
    
}
