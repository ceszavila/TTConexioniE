//
//  EditarViewController.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 21/05/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase

var refCursosEditar : DatabaseReference!

class EditarViewController: UIViewController {
    @IBOutlet weak var notificacionlbl: UILabel!
    @IBOutlet weak var nombreCurso: UITextField!
    @IBOutlet weak var nombreCursolbl: UILabel!
    
    @IBOutlet weak var diaInicioCurso: UITextField!
    @IBOutlet weak var mesInicioCurso: UITextField!
    @IBOutlet weak var aniInicioCurso: UITextField!
    @IBOutlet weak var iniciolbl: UILabel!
    @IBOutlet weak var diaFinCurso: UITextField!
    @IBOutlet weak var mesFinCurso: UITextField!
    @IBOutlet weak var anoFinCurso: UITextField!
    @IBOutlet weak var terminalbl: UILabel!
    
    @IBOutlet weak var costoCurso: UITextField!
    @IBOutlet weak var costolbl: UILabel!
    @IBOutlet weak var costoIPNCurso: UITextField!
    @IBOutlet weak var costoIPNlbl: UILabel!
    @IBOutlet weak var descripcionCurso: UITextView!
    @IBOutlet weak var descripcionlbl: UILabel!
    @IBOutlet weak var requisitosCurso: UITextView!
    @IBOutlet weak var requisitoslbl: UILabel!
    @IBOutlet weak var urlCurso: UITextField!
    @IBOutlet weak var urllbl: UILabel!
    
    var cursos : Curso!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificacionlbl.text = ""
        refCursosEditar = Database.database().reference().child("cursos");
        let idCurso = cursos.idCurso
        nombreCurso.text = cursos.nombreCurso!
        costoIPNCurso.text = cursos.costoIPNCurso!
        costoCurso.text = cursos.costoCurso!
        descripcionCurso.text = cursos.descripcionCurso!
        requisitosCurso.text = cursos.requisitosCurso!
        urlCurso.text = cursos.urlCurso!
   
        let fullStartDate : String = cursos.fechaInicioCurso!
        let fullDate = fullStartDate.components(separatedBy: "/")
        let diaInicio : String = fullDate[0]
        let mesInicio : String = fullDate[1]
        let anoInicio : String = fullDate[2]
        print(fullDate)
        diaInicioCurso.text = diaInicio
        mesInicioCurso.text = mesInicio
        aniInicioCurso.text = anoInicio
        
        let fullFinishDate : String = cursos.fechaFinCurso!
        let fullFinish = fullFinishDate.components(separatedBy: "/")
        print(fullFinish)
        let diaFin : String = fullFinish[0]
        let mesFin : String = fullFinish[1]
        let anoFin : String = fullFinish[2]
        
        diaFinCurso.text = diaFin
        mesFinCurso.text = mesFin
        anoFinCurso.text = anoFin
        
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
    
    @IBAction func editarCurso(_ sender: Any) {
        let idCurso = self.cursos.idCurso!
        if (nombreCurso.text != "" && diaInicioCurso.text != "" && mesInicioCurso.text != "" && aniInicioCurso.text != "" && diaFinCurso.text != "" && mesFinCurso.text != "" && anoFinCurso.text != "" && costoIPNCurso.text != "" && costoCurso.text != "" && descripcionCurso.text != "" && requisitosCurso.text != "" && urlCurso.text != "") {
            if (diaInicioCurso.text?.count == 2 && mesInicioCurso.text?.count == 2 && aniInicioCurso.text?.count == 4 && diaFinCurso.text?.count == 2 && mesFinCurso.text?.count == 2 && anoFinCurso.text?.count == 4) {
                let fechaDeInicio : String = "\(diaInicioCurso.text!)/\(mesInicioCurso.text!)/\(anoFinCurso.text!)"
                let fechaDeTermino : String = "\(diaFinCurso.text!)/\(mesFinCurso.text!)/\(anoFinCurso.text!)"
                let cursos = ["id_curso" : idCurso,
                              "nombre_curso" : nombreCurso.text! as String,
                              "descripcion_curso" : descripcionCurso.text! as String,
                              "requisito_curso" : requisitosCurso.text! as String,
                              "fechaInicio_curso" : fechaDeInicio as String,
                              "fechaFin_curso" : fechaDeTermino as String,
                              "costo_curso" : costoCurso.text! as String,
                              "costoIPN_curso" : costoIPNCurso.text! as String,
                              "url_curso" : urlCurso.text! as String
                ]
                refCursos.child(idCurso).setValue(cursos)
                notificacionlbl.textColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
                notificacionlbl.text = "El curso se editó exitosamente"
            } else{
                notificacionlbl.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                notificacionlbl.text = "Fecha incorrecta"
            }
        } else{
            notificacionlbl.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            notificacionlbl.text = "Faltan campos obligatorios"
        }
    }
    
    func borrarCurso(idCurso:String){
        refCursosEditar.child(idCurso).setValue(nil)
    }
    
    @IBOutlet weak var eliminarCurso: UIButton!
    
    
    @IBAction func borrarCurso(_ sender: Any) {
        let alertController = UIAlertController(title: " Esta seguro que desea eliminar el curso \(cursos.nombreCurso!) ", message: "", preferredStyle: .alert)
        let eliminarCurso = UIAlertAction(title: "Eliminar ", style: .destructive) { (_) in
            self.borrarCurso(idCurso:self.cursos.idCurso)
        }
        let cancelarOperacion = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        alertController.addAction(eliminarCurso)
        alertController.addAction(cancelarOperacion)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
}
