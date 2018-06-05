//
//  RegistrarCursoViewController.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 20/05/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase

class RegistrarCursoViewController: UIViewController {
    @IBOutlet weak var nombreCurso: UITextField!
    @IBOutlet weak var diaInicioCurso: UITextField!
    @IBOutlet weak var mesInicioCurso: UITextField!
    @IBOutlet weak var anoInicioCurso: UITextField!
    @IBOutlet weak var diaFinCurso: UITextField!
    @IBOutlet weak var mesFinCurso: UITextField!
    @IBOutlet weak var anoFinCurso: UITextField!
    @IBOutlet weak var costoCurso: UITextField!
    @IBOutlet weak var costoIPNCurso: UITextField!
    @IBOutlet weak var descripcionCurso: UITextView!
    @IBOutlet weak var requisitosCurso: UITextView!
    @IBOutlet weak var urlCurso: UITextField!
    
    @IBOutlet weak var notificacionlbl: UILabel!
    var cursosList = [Curso]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        notificacionlbl.text = ""
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

    func registrarCurso(){
        if (nombreCurso.text != "" && diaInicioCurso.text != "" && mesInicioCurso.text != "" && anoInicioCurso.text != "" && diaFinCurso.text != "" && mesFinCurso.text != "" && anoFinCurso.text != "" && costoIPNCurso.text != "" && costoCurso.text != "" && descripcionCurso.text != "" && requisitosCurso.text != "" && urlCurso.text != "") {
            if (diaInicioCurso.text?.count == 2 && mesInicioCurso.text?.count == 2 && anoInicioCurso.text?.count == 4 && diaFinCurso.text?.count == 2 && mesFinCurso.text?.count == 2 && anoFinCurso.text?.count == 4) {
            let fechaDeInicio : String = "\(diaInicioCurso.text!)/\(mesInicioCurso.text!)/\(anoFinCurso.text!)"
            let fechaDeTermino : String = "\(diaFinCurso.text!)/\(mesFinCurso.text!)/\(anoFinCurso.text!)"
            let key = refCursos.childByAutoId().key
            let cursos = ["id_curso" : key,
                          "nombre_curso" : nombreCurso.text! as String,
                          "descripcion_curso" : descripcionCurso.text! as String,
                          "requisito_curso" : requisitosCurso.text! as String,
                          "fechaInicio_curso" : fechaDeInicio as String,
                          "fechaFin_curso" : fechaDeTermino as String,
                          "costo_curso" : costoCurso.text! as String,
                          "costoIPN_curso" : costoIPNCurso.text! as String,
                          "url_curso" : urlCurso.text! as String
            ]
            refCursos.child(key).setValue(cursos)
            notificacionlbl.text = "El curso se registró exitosamente"
            } else{
                notificacionlbl.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                notificacionlbl.text = "Fecha incorrecta"
            }
        } else{
            notificacionlbl.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            notificacionlbl.text = "Faltan campos obligatorios"
        }
    }
    
    @IBAction func registrarCurso(_ sender: Any) {
       registrarCurso()
    }
    

}
