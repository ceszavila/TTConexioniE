//
//  RegistrarUAViewController.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 26/03/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase

var refUnidad : DatabaseReference!

class RegistrarUAViewController: UIViewController {
    @IBOutlet weak var nombreUnidad: UITextField!
    @IBOutlet weak var tipoUnidad: UITextField!
    @IBOutlet weak var programaUnidad: UITextField!
    @IBOutlet weak var academiaUnidad: UITextField!

    @IBOutlet weak var notificacionlbl: UILabel!
    var uaList = [UnidadDeAprendizaje]()
    
    override func viewDidLoad() {
         super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        notificacionlbl.text = ""
        //Descomentar, si el tap no debe interferir o cancelar otras acciones
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        refUnidad = Database.database().reference().child("unidadesAprendizaje");
    }
    
    
    func agregarUnidad(){
        if (nombreUnidad.text != "" && tipoUnidad.text != "" && academiaUnidad.text != "" && programaUnidad.text != ""){
        let key = refUnidad.childByAutoId().key // CREANDO EL ID UNICO PARA UA
        let unidad = ["id_unidad" : key,
                      "nombre_unidad": nombreUnidad.text! as String,
                      "tipo_unidad":tipoUnidad.text! as String,
                      "academia_unidad":academiaUnidad.text! as String,
                      "programa_unidad":programaUnidad.text! as String
                    ]
        refUnidad.child(key).setValue(unidad) // AÑADIENDO A PROFESOR A FIREBASE DATABASE CON LA ESTRUCTURA JSON
        notificacionlbl.text = "Unidad agregada exitosamente"
        }else{
            notificacionlbl.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            notificacionlbl.text = "Faltan campos obligatorios"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func regristrarUnidadAprendizaje(_ sender: Any) {
        agregarUnidad()
    }
    

}
