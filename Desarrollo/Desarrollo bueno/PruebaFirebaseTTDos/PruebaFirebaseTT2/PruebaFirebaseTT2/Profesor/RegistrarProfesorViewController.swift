//
//  RegistrarProfesorViewController.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 30/03/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase
import Photos

var refProf : DatabaseReference!

class RegistrarProfesorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var textFieldNombre: UITextField!
    @IBOutlet weak var textFieldCubiculo: UITextField!
    @IBOutlet weak var textFieldAcademia: UITextField!
    @IBOutlet weak var textFieldCorreo: UITextField!
    @IBOutlet weak var textFieldTelefono: UITextField!
    @IBOutlet weak var textFieldPaginaWeb: UITextField!
    @IBOutlet weak var textFieldMaterias: UITextField!
    @IBOutlet weak var textFieldTT: UITextField!
    @IBOutlet weak var fotoProfesor: UIImageView!
    @IBOutlet weak var msjlbl: UILabel!
    
    var profesorList = [Profesor]()
        let imagePickerController = UIImagePickerController()
        override func viewDidLoad() {
            super.viewDidLoad()
            msjlbl.text = ""
            imagePickerController.delegate = self
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
            //Descomentar, si el tap no debe interferir o cancelar otras acciones
            tap.cancelsTouchesInView = false
            
            view.addGestureRecognizer(tap)
            
            refProf = Database.database().reference().child("profesores version FireStorage");
            
            
                fotoProfesor.image = UIImage(named: "user")
                fotoProfesor.translatesAutoresizingMaskIntoConstraints = false
                fotoProfesor.clipsToBounds = true
                fotoProfesor.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(handleSelectProfileImageView)))
                fotoProfesor.isUserInteractionEnabled = true
            
            
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
        fotoProfesor.image = selectedImage
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
    
    @IBAction func agregarProfesor(_ sender: Any) {
        let storageRef = Storage.storage().reference().child("PROFESORES").child(textFieldNombre.text!)
        if let uploadData = UIImagePNGRepresentation(self.fotoProfesor.image!){
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    print(error!)
                    return
                }
                print(metadata!)
                self.msjlbl.text = "Foto registrada"
            })
        }
        let key = refProf.childByAutoId().key // CREANDO EL ID UNICO PARA EL PROFESOR DENTRO DE FIREBASE
        let profesor = ["id_profesor" : key,
                        "nombre_profesor" : textFieldNombre.text! as String,
                        "academia_profesor" : textFieldAcademia.text! as String,
                        "cubiculo_profesor" : textFieldCubiculo.text! as String,
                        "fotografia_profesor" : textFieldNombre.text! as String,
                        "correo_profesor": textFieldCorreo.text! as String,
                        "telefono_profesor" : textFieldTelefono.text! as String,
                        "pagina_profesor" : textFieldPaginaWeb.text! as String,
                        "materia_profesor" : textFieldMaterias.text! as String,
                        "tt_profesor" : textFieldTT.text! as String
        ]
        refProf.child(key).setValue(profesor) // añadiendo profesores a FIREBASE DATABASE con la estructura del JSON
        msjlbl.text = "Profesor registrado"
        
        textFieldNombre.text = ""
        textFieldAcademia.text = ""
        textFieldCubiculo.text = ""
        textFieldCorreo.text = ""
        textFieldTelefono.text = ""
        textFieldPaginaWeb.text = ""
        textFieldTT.text = ""
        textFieldMaterias.text = ""
    }
    @IBOutlet weak var agregarProfesor: UIButton!


}
