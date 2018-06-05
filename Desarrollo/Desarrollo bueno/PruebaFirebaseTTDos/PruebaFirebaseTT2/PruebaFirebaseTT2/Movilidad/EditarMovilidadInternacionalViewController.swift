//
//  EditarMovilidadInternacionalViewController.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 19/05/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase

var refEditarInternacional : DatabaseReference!

class EditarMovilidadInternacionalViewController: UIViewController {
    
    @IBOutlet weak var titulolbl: UILabel!
    
    @IBOutlet weak var eliminarBTN: UIButton!
    @IBOutlet weak var editarBTN: UIButton!
    @IBOutlet weak var periodoInternacionallbl: UILabel!
    @IBOutlet weak var anoInternacionallbl: UILabel!
    
    @IBOutlet weak var uniInternacionallbl: UILabel!
    
    @IBOutlet weak var convocatoriaInternacionallbl: UILabel!
    
    var movilidadInternacionalEditar : MovilidadInternacional!
    
    @IBOutlet weak var resultadosInternacionallbl: UILabel!
    @IBOutlet weak var msjlbl: UILabel!
    @IBOutlet weak var periodoInternacional: UITextField!
    @IBOutlet weak var anoInternacional: UITextField!
    @IBOutlet weak var universidadInternacional: UITextField!
    @IBOutlet weak var resultadosInternacional: UITextField!
    @IBOutlet weak var convocatoriaInternacional: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        msjlbl.text = ""
        refEditarInternacional = Database.database().reference().child("internacional");
        let idInternacional = movilidadInternacionalEditar.idInternacional
        
        periodoInternacional.text = movilidadInternacionalEditar.periodo!
        anoInternacional.text = movilidadInternacionalEditar.ano!
        universidadInternacional.text = movilidadInternacionalEditar.universidad!
        convocatoriaInternacional.text = movilidadInternacionalEditar.convocatoria!
        resultadosInternacional.text = movilidadInternacionalEditar.resultados!
        
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
    

    @IBAction func editarInternacional(_ sender: Any) {
        let idInternacional = self.movilidadInternacionalEditar.idInternacional!
        let movilidadInternacional = ["id_internacional" : idInternacional,
                                      "ano_internacional" : anoInternacional.text! as String,
                                      "periodo_internacional" : periodoInternacional.text! as String,
                                      "convocatoria_internacional" : convocatoriaInternacional.text! as String,
                                      "universidad_internacional" : universidadInternacional.text! as String,
                                      "resultado_internacional" : resultadosInternacional.text! as String
        ]
        refEditarInternacional.child(idInternacional).setValue(movilidadInternacional)
        msjlbl.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        msjlbl.text = "La movilidad internacional se editó exitosamente"
    }
    
    func borrarMovilidadInternacional(idInternacional:String){
        refEditarInternacional.child(idInternacional).setValue(nil)
        periodoInternacional.isHidden = true
        periodoInternacionallbl.isHidden = true
        anoInternacional.isHidden = true
        anoInternacionallbl.isHidden = true
        convocatoriaInternacional.isHidden = true
        convocatoriaInternacionallbl.isHidden = true
        universidadInternacional.isHidden = true
        uniInternacionallbl.isHidden = true
        resultadosInternacional.isHidden = true
        resultadosInternacionallbl.isHidden = true
        editarBTN.isHidden = true
        eliminarBTN.isHidden = true
        
        msjlbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        msjlbl.text = "Por favor presione el botón atras"
        titulolbl.text = "La movilidad internacional ha sido eliminada exitosamente"
    }
    
    @IBAction func eliminarInternacional(_ sender: Any) {
        let alertController = UIAlertController(title: " Esta seguro que desea eliminar la movilidad internacional \(movilidadInternacionalEditar.periodo!) \(movilidadInternacionalEditar.ano!)", message: "", preferredStyle: .alert)
        let eliminarMovilidadNacional = UIAlertAction(title: "Eliminar ", style: .destructive) { (_) in
            self.borrarMovilidadInternacional(idInternacional: self.movilidadInternacionalEditar.idInternacional)
        }
        let cancelarOperacion = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        alertController.addAction(eliminarMovilidadNacional)
        alertController.addAction(cancelarOperacion)
        present(alertController, animated: true, completion: nil)
    }
    
   
    
}
