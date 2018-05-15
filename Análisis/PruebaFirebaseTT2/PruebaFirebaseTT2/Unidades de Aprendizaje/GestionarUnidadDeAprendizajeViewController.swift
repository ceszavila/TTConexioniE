//
//  GestionarUnidadDeAprendizajeViewController.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 26/03/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase

var refUA : DatabaseReference!

class GestionarUnidadDeAprendizajeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var unidadTabla: UITableView!
    
    
    @IBOutlet weak var notificacionlbl: UILabel!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let unidadAprendizaje = uaList[indexPath.row]
        
        let alertControlloer = UIAlertController(title:unidadAprendizaje.nombreUA,message:"", preferredStyle:.alert)
        
        let actualizarUnidad = UIAlertAction(title: "Actualizar", style: .default) { (_) in
            let id = unidadAprendizaje.idUA
            
            let nombreUA = alertControlloer.textFields?[0].text
            let tipoUA = alertControlloer.textFields?[1].text
            let academiaUA = alertControlloer.textFields?[2].text
            let programaUA = alertControlloer.textFields?[3].text
            
            self.actualizaUA(idUA:id!, nombreUA: nombreUA!, tipoUA: tipoUA!, academiaUA: academiaUA!, programaUA: programaUA!)
            
        }
        
        let eliminarUnidad = UIAlertAction(title: "Eliminar", style: .destructive) { (_) in
          self.borrarUA(idUA: unidadAprendizaje.idUA!)
        }
        
        
        alertControlloer.addTextField{(textField) in
            textField.text = unidadAprendizaje.nombreUA
        }
        alertControlloer.addTextField{(textField) in
            textField.text = unidadAprendizaje.tipo
        }
        alertControlloer.addTextField{(textField) in
            textField.text = unidadAprendizaje.academia
        }
        alertControlloer.addTextField{(textField) in
            textField.text = unidadAprendizaje.programaAcademico
        }
        
        let cancelarOperacion = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        
        alertControlloer.addAction(actualizarUnidad)
        alertControlloer.addAction(eliminarUnidad)
        alertControlloer.addAction(cancelarOperacion)
        
        present(alertControlloer, animated: true,completion: nil)
        
    }
    
    func borrarUA(idUA:String){
        refUA.child(idUA).setValue(nil)
        notificacionlbl.text = "La unidad de aprendizaje se eliminó exitosamente"
    }
  
    
    func actualizaUA(idUA: String, nombreUA:String,tipoUA:String,academiaUA:String,programaUA:String) {
        let unidadAprendizaje = ["id_unidad" : idUA,
                                 "nombre_unidad": nombreUA,
                                 "tipo_unidad":tipoUA,
                                 "academia_unidad":academiaUA,
                                 "programa_unidad":programaUA
                                ]
        refUA.child(idUA).setValue(unidadAprendizaje)
        notificacionlbl.text = "La unidad de aprendizaje se actualizó exitosamente"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellUA", for: indexPath) as! UnidadesDeAprendizajeTableViewCell
        let unidad : UnidadDeAprendizaje
        
        unidad = uaList[indexPath.row]
        
        cell.nombreUA.text = unidad.nombreUA
        return cell
    }
    
    var uaList = [UnidadDeAprendizaje]()

    override func viewDidLoad() {
        super.viewDidLoad()
        notificacionlbl.text = ""
        refUA = Database.database().reference().child("unidadesAprendizaje");
        
        refUA.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount>0{
                self.uaList.removeAll()
                
                for unidad in snapshot.children.allObjects as! [DataSnapshot]{
                    let unidadObject = unidad.value as? [String:AnyObject]
                    let unidadNombre = unidadObject!["nombre_unidad"]
                    let unidadId = unidadObject!["id_unidad"]
                    let unidadAcademia = unidadObject!["academia_unidad"]
                    let unidadPrograma = unidadObject!["programa_unidad"]
                    let unidadTipo = unidadObject!["tipo_unidad"]
                    
                    let unidad = UnidadDeAprendizaje(idUA:unidadId as! String, nombreUA: unidadNombre as! String, tipo: unidadTipo as! String, programaAcademico: unidadPrograma as! String, academia: unidadAcademia as! String)
                    
                    self.uaList.append(unidad)
                    
                }
            }
            self.unidadTabla.reloadData()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func agregarUA(_ sender: Any) {
    }
    
   
    
}
