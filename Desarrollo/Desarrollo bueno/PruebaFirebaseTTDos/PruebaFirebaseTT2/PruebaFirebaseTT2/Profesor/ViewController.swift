//
//  ViewController.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 24/03/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase

var refProfesor : DatabaseReference!
var imageReference : StorageReference{
    return Storage.storage().reference().child("PROFESORES")
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profesorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        let profesor : Profesor
        
        
        
        
        profesor = profesorList[indexPath.row]
        
        cell.lblNombreProfesor.text = profesor.nombre
        cell.lblCubiculoProfesor.text = profesor.cubiculo
        
        let downloadImageRef = imageReference.child(profesor.nombre!)
        let downloadTask = downloadImageRef.getData(maxSize: 1024 * 1024 * 2014) { (data, error) in
            if let error = error{
                print ("Error: \(error)")
            } else{
                let image = UIImage(data: data!)
                cell.fotoProfesor.image = image
                 cell.fotoProfesor.clipsToBounds = true
            }
        }
        
        return cell
    }
    
    
    
   
    @IBOutlet weak var tblProfesor: UITableView!
    @IBOutlet weak var textFieldNombre: UITextField!
    @IBOutlet weak var textFieldCubiculo: UITextField!
    @IBOutlet weak var textFieldAcademia: UITextField!
    @IBOutlet weak var textFieldFoto: UITextField!
    @IBOutlet weak var textFieldMail: UITextField!
    @IBOutlet weak var textFieldTelefono: UITextField!
    @IBOutlet weak var textFieldPagina: UITextField!
    @IBOutlet weak var textFieldMaterias: UITextField!
    @IBOutlet weak var textFieldTT: UITextField!
    @IBOutlet weak var labelMensaje: UILabel!
    
    // INSTANCIA DE PROFESORES
    
    var profesorList =  [Profesor]()
    var profesor : Profesor!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        //Descomentar, si el tap no debe interferir o cancelar otras acciones
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        refProfesor = Database.database().reference().child("profesores version FireStorage");
        
        // HACIENDO CONSULTA DE LOS PROFESORES
        
        refProfesor.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount>0{
                self.profesorList.removeAll()
                
                for profesor in snapshot.children.allObjects as! [DataSnapshot]{
                    let profesorObject = profesor.value as? [String:AnyObject]
                    let profesorNombre = profesorObject!["nombre_profesor"]
                    let profesorCubiculo = profesorObject!["cubiculo_profesor"]
                    let profesorId = profesorObject!["id_profesor"]
                    let profesorAcademia = profesorObject!["academia_profesor"]
                    let profesorFotografia = profesorObject!["fotografia_profesor"]
                    let profesorCorreo = profesorObject!["correo_profesor"]
                    let profesorTelefono = profesorObject!["telefono_profesor"]
                    let profesorPagina = profesorObject!["pagina_profesor"]
                    let profesorMateria = profesorObject!["materia_profesor"]
                    let profesorTT = profesorObject!["tt_profesor"]

                    let profesor = Profesor(idProf: profesorId as! String, nombre: profesorNombre as! String, fotografia: profesorFotografia as! String, cubiculo: profesorCubiculo as! String, email: profesorCorreo as! String, telefono: profesorTelefono as! String, paginaWeb: profesorPagina as! String, horarioAtencion: profesorCubiculo as! String, academia: profesorAcademia as! String, materias: profesorMateria as! String, trabajoTerminal: profesorTT as! String)
                    
                    self.profesorList.append(profesor)
                    
                    
                }
                
            }
            
            
            
            
            
            self.tblProfesor.reloadData()
            
        }
    }

    @objc func dismissKeyboard() {
        //Las vistas y toda la jerarquía renuncia a responder, para esconder el teclado
        view.endEditing(true)
    }
    
    func agregarProfesor(){
        
        let key = refProfesor.childByAutoId().key // CREANDO EL ID UNICO PARA EL PROFESOR DENTRO DE FIREBASE
        
        let profesor = ["id_profesor" : key,
                        "nombre_profesor" : textFieldNombre.text! as String,
                        "academia_profesor" : textFieldAcademia.text! as String,
                        "cubiculo_profesor" : textFieldCubiculo.text! as String,
                        "fotografia_profesor" : textFieldFoto.text! as String,
                        "correo_profesor": textFieldMail.text! as String,
                        "telefono_profesor" : textFieldTelefono.text! as String,
                        "pagina_profesor" : textFieldPagina.text! as String,
                        "materia_profesor" : textFieldMaterias.text! as String,
                        "tt_profesor" : textFieldTT.text! as String
                        ]
        refProfesor.child(key).setValue(profesor) // añadiendo profesores a FIREBASE DATABASE con la estructura del JSON
        
        
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func agregarProfesor(_ sender: Any) {
        agregarProfesor()
    }
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //NOS ASEGURAMOS QUE SI SEA EL SEGUE QUE QUEREMOS CON E IDENTIFICADOR QUE LE PUSIMOS AL SEGUE
        if segue.identifier == "editarProfesor"{
            // AHORA HAY QUE DECIRLE QUE CELDA HA SIDO SELECCIONADA Y RECUPERAR EL INDEXPATH SELECCIONADO
            // EN CASE DE QUE EL INDEXPAH SELECCIONADO EN CONCRETO, VA A SER UNA VARIABLE ASGINDA DE TIPO INDEXPATH, SI NO SE SELECCIONA NADA ESTA VARIABLE SERA NULA Y NO SE EJECUTARA ESTE SEGMENTO DE CODIGO
            if let indexpath = self.tblProfesor.indexPathForSelectedRow{
                // SELECCIONAMOS AL PROFESOR
                let profesorseleccionado = self.profesorList[indexpath.row]
                // DECIR QUIEN ES EL VIEWCONTROLLER DE DESTINO Y ESTO LO SABE EL SEGUE CON EL DESTINATITON ASI QUE TENEMOS QUE HACER UN CASTING Y ASIGNAR LA VARIABLE PROFESOR QUE SE CREO EN EL DETALLESPROFESOR.SWIFT TIENE QUE SER NI MAS NI MENOS QUE EL PROFESOR SELEECIONADO DEL INDEXPATH QUE HA LLEGADO
                let destinationViewController = segue.destination as! EditarProfesor
                destinationViewController.profesor = profesorseleccionado
                
            }
        }
    }
    
}

 

