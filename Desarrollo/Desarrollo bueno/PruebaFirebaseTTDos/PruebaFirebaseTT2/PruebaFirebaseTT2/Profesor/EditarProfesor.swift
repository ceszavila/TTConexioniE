//
//  EditarProfesor.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 11/04/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase
import Photos

var referenceProfesor : DatabaseReference!
var imageReferences : StorageReference{
    return Storage.storage().reference().child("PROFESORES")
}


class EditarProfesor: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
var profesor : Profesor!
    
    @IBOutlet weak var nombreProfesorlbl: UITextField!
    @IBOutlet weak var cubiculoProfesorlbl: UITextField!
    @IBOutlet weak var academiaProfesorlbl: UITextField!
    @IBOutlet weak var correoProfesorlbl: UITextField!
    @IBOutlet weak var telefonoProfesorlbl: UITextField!
    @IBOutlet weak var paginaProfesorlbl: UITextField!
    @IBOutlet weak var materiasProfesorlbl: UITextField!
    @IBOutlet weak var ttprofesorlbl: UITextField!
    @IBOutlet weak var fotoprofesor: UIImageView!
    @IBOutlet weak var msjlbl: UILabel!
    
    @IBOutlet weak var titulolbl: UILabel!
    @IBOutlet weak var nombrelbl: UILabel!
    @IBOutlet weak var cubiculolbl: UILabel!
    @IBOutlet weak var academialbl: UILabel!
    @IBOutlet weak var emaillbl: UILabel!
    @IBOutlet weak var telefonolbl: UILabel!
    @IBOutlet weak var paginalbl: UILabel!
    @IBOutlet weak var materiaslbl: UILabel!
    @IBOutlet weak var ttlbl: UILabel!
    @IBOutlet weak var editarlbl: UIButton!
    @IBOutlet weak var eliminarlbl: UIButton!
    
    
    var profesorList = [Profesor]()
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        msjlbl.text = ""
         let idProf = profesor.idProf
        
        nombreProfesorlbl.text = profesor.nombre!
        cubiculoProfesorlbl.text = profesor.cubiculo!
        academiaProfesorlbl.text = profesor.academia!
        correoProfesorlbl.text = profesor.email!
        telefonoProfesorlbl.text = profesor.telefono!
        paginaProfesorlbl.text = profesor.paginaWeb!
        materiasProfesorlbl.text = profesor.materias!
        ttprofesorlbl.text = profesor.trabajoTerminal!
        
        referenceProfesor = Database.database().reference().child("profesores version FireStorage")
        fotoprofesor.image = UIImage(named: "\(profesor.nombre!)")
        fotoprofesor.translatesAutoresizingMaskIntoConstraints = false
        fotoprofesor.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(handleSelectProfileImageView)))
        fotoprofesor.isUserInteractionEnabled = true
        
        
        let downloadImageRef = imageReference.child(profesor.nombre!)
        let downloadTask = downloadImageRef.getData(maxSize: 1024 * 1024 * 2014) { (data, error) in
            if let error = error{
                print ("Error: \(error)")
            } else{
                let image = UIImage(data: data!)
                self.fotoprofesor.image = image
                self.fotoprofesor.clipsToBounds = true
            }
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        //Descomentar, si el tap no debe interferir o cancelar otras acciones
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
       
        // Do any additional setup after loading the view.
    }
    
    func authorizeToAlbum(completion:@escaping (Bool)->Void) {
        
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            NSLog("Will request authorization")
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == .authorized {
                    DispatchQueue.main.async(execute: {
                        completion(true)
                    })
                } else {
                    DispatchQueue.main.async(execute: {
                        completion(false)
                    })
                }
            })
            
        } else {
            DispatchQueue.main.async(execute: {
                completion(true)
            })
        }
    }
    
    
    
    @objc func handleSelectProfileImageView(){
        
        self.authorizeToAlbum { (authorized) in
            if authorized == true {
                
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                picker.sourceType = .photoLibrary
                self.present(picker, animated: true, completion: nil)
            }
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker : UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            //self.fotoProfesor.image = editedImage
            selectedImageFromPicker = editedImage
            print(editedImage)
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            // self.fotoProfesor.image = originalImage
            selectedImageFromPicker = originalImage
            print(originalImage)
        }
        if let selectedImage = selectedImageFromPicker{
            fotoprofesor.image = selectedImage
        }
        dismiss(animated: true,completion:nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel picker")
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func dismissKeyboard() {
        //Las vistas y toda la jerarquía renuncia a responder, para esconder el teclado
        view.endEditing(true)
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
    
    
    @IBAction func editarBtn(_ sender: Any) {
        
        let idProf = self.profesor.idProf!
        
        let downloadImageRef = imageReference.child(self.profesor.nombre!)
        downloadImageRef.delete { error in
            if let error = error{
                print("Error")
            }else{
                print("Eliminando imagen")
            }
        }
        
        let storageRef = Storage.storage().reference().child("PROFESORES").child(nombreProfesorlbl.text!)
        if let uploadData = UIImagePNGRepresentation(self.fotoprofesor.image!){
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    print(error!)
                    return
                }
                print(metadata!)
                self.msjlbl.text = "El profesor se actualizó correctamente"
                print("El profesor se actualizo exitosamente")
            })
        }
        
        let profesor = ["id_profesor" : idProf,
                        "nombre_profesor" : nombreProfesorlbl.text! as String,
                        "academia_profesor" : academiaProfesorlbl.text! as String,
                        "cubiculo_profesor" : cubiculoProfesorlbl.text! as String,
                        "fotografia_profesor" : nombreProfesorlbl.text! as String,
                        "correo_profesor": correoProfesorlbl.text! as String,
                        "telefono_profesor" : telefonoProfesorlbl.text! as String,
                        "pagina_profesor" : paginaProfesorlbl.text! as String,
                        "materia_profesor" : materiasProfesorlbl.text! as String,
                        "tt_profesor" : ttprofesorlbl.text! as String
        
        ]
        referenceProfesor.child(idProf).setValue(profesor)
         msjlbl.text = "El profesor se editó exitosamente"
    
    }
    func borrarProfesor(idProf:String){
        referenceProfesor.child(idProf).setValue(nil)
        let downloadImageRef = imageReference.child(self.profesor.nombre!)
        downloadImageRef.delete { error in
            if let error = error{
                print("Error")
            }else{
                print("Eliminando imagen")
            }
        }
   
        nombreProfesorlbl.isHidden = true
        cubiculoProfesorlbl.isHidden = true
        academiaProfesorlbl.isHidden = true
        correoProfesorlbl.isHidden = true
        telefonoProfesorlbl.isHidden = true
        paginaProfesorlbl.isHidden = true
        materiasProfesorlbl.isHidden = true
        ttprofesorlbl.isHidden = true
        fotoprofesor.isHidden = true
        nombrelbl.isHidden = true
        cubiculolbl.isHidden = true
        academialbl.isHidden = true
        emaillbl.isHidden = true
        telefonolbl.isHidden = true
        paginalbl.isHidden = true
        materiaslbl.isHidden = true
        ttlbl.isHidden = true
        editarlbl.isHidden = true
        eliminarlbl.isHidden = true
        titulolbl.text = "El profesor ha sido eliminado existosamente"
        
        msjlbl.text = "Por favor seleccione el botón atras"
        
        
        let alertController = UIAlertController(title: "El profesor se eliminó exitosamente", message: "", preferredStyle: .alert)
        let aceptarOperación = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alertController.addAction(aceptarOperación)
        present(alertController, animated: true, completion: nil)
    }
   
    @IBOutlet weak var eliminarProfesor: UIButton!
    
    @IBAction func borrarProfesor(_ sender: Any) {
        let alertController = UIAlertController(title: profesor.nombre, message: "", preferredStyle: .alert)
        let eliminarProfesro = UIAlertAction(title: "Eliminar", style: .destructive) { (_) in
            self.borrarProfesor(idProf: self.profesor.idProf)
        }
        let cancelarOperacion = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        alertController.addAction(eliminarProfesro)
        alertController.addAction(cancelarOperacion)
        present(alertController, animated: true, completion: nil)
    }
    
}
