//
//  RegistrarMovilidadViewController.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 16/05/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase

var refMovInter : DatabaseReference!
var refMovNac : DatabaseReference!

class RegistrarMovilidadViewController: UIViewController {
    @IBOutlet weak var periodoMovilidad: UITextField!
    @IBOutlet weak var anoMovilidad: UITextField!
    @IBOutlet weak var universidadMovilidad: UITextField!
    @IBOutlet weak var convocatoriaMovilidad: UITextField!
    @IBOutlet weak var resultadosMovilidad: UITextField!
    @IBOutlet weak var tipoMovilidad: UISegmentedControl!
    @IBOutlet weak var notificacionlbl: UILabel!
    var nacionalList = [MovilidadNacional]()
    var internacionalList = [MovilidadInternacional]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        notificacionlbl.text = ""
        //Descomentar, si el tap no debe interferir o cancelar otras acciones
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
         refMovNac = Database.database().reference().child("nacional");
        refMovInter = Database.database().reference().child("internacional");
        
    }
    
    @objc func dismissKeyboard() {
        //Las vistas y toda la jerarquía renuncia a responder, para esconder el teclado
        view.endEditing(true)
    }
    func registrarMovilidad(){
        switch tipoMovilidad.selectedSegmentIndex {
        case 0:
            if(periodoMovilidad.text != "" && anoMovilidad.text != "" && universidadMovilidad.text != "" && convocatoriaMovilidad.text != "" && resultadosMovilidad.text != ""){
                let key = refMovInter.childByAutoId().key // CREANDO ID PARA MOVILIDAD
                let movilidadInternacional = ["id_internacional" : key,
                                              "ano_internacional" : anoMovilidad.text! as String,
                                              "periodo_internacional" : periodoMovilidad.text! as String,
                                              "convocatoria_internacional" : convocatoriaMovilidad.text! as String,
                                              "universidad_internacional" : universidadMovilidad.text! as String,
                                              "resultado_internacional" : resultadosMovilidad.text! as String
                                              ]
                refMovInter.child(key).setValue(movilidadInternacional)
                notificacionlbl.textColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
                notificacionlbl.text = "La movilidad internacional se registró exitosamente"
            }else{
                notificacionlbl.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                notificacionlbl.text = "Faltan campos obligatorios"
            }
        case 1:
            if(periodoMovilidad.text != "" && anoMovilidad.text != "" && universidadMovilidad.text != "" && convocatoriaMovilidad.text != "" && resultadosMovilidad.text != ""){
                let key = refMovNac.childByAutoId().key // CREANDO ID PARA MOVILIDAD
                let movilidadNacional = ["id_nacional" : key,
                                              "ano_nacional" : anoMovilidad.text! as String,
                                              "periodo_nacional" : periodoMovilidad.text! as String,
                                              "convocatoria_nacional" : convocatoriaMovilidad.text! as String,
                                              "universidad_nacional" : universidadMovilidad.text! as String,
                                              "resultado_nacional" : resultadosMovilidad.text! as String
                ]
                refMovNac.child(key).setValue(movilidadNacional)
                 notificacionlbl.textColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
                notificacionlbl.text = "La movilidad nacional se registró exitosamente"
            }
            else{
                notificacionlbl.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                notificacionlbl.text = "Faltan campos obligatorios"
            }
        default:
            break
        }
      
    }
    @IBAction func agregarMovilidad(_ sender: Any) {
        registrarMovilidad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
