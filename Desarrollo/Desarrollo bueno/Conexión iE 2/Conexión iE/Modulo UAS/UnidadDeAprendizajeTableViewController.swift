//
//  UnidadDeAprendizajeTableViewController.swift
//  Conexión iE
//
//  Created by Cesar Avila on 07/04/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase

var refUA : DatabaseReference!
class UnidadDeAprendizajeTableViewController: UITableViewController {
    @IBOutlet var uaTabla: UITableView!
    var uaList = [UnidadDeAprendizaje]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Unidades de Aprendizaje"
        
        refUA = Database.database().reference().child("unidadesAprendizaje");
        
        refUA.queryOrdered(byChild: "nombre_unidad").observe(DataEventType.value) { (snapshot) in
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
            self.uaTabla.reloadData()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return uaList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "uaCelda", for: indexPath) as! UnidadDeAprendizajeTableViewCell
        let unidadDeAprendizaje = uaList[indexPath.row]
        cell.nombreUA.text = unidadDeAprendizaje.nombreUA

        // Configure the cell...

        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        if segue.identifier == "detalleUA"{
            if let indexpath = self.tableView.indexPathForSelectedRow{
                let uaSel = self.uaList[indexpath.row]
                let destinationViewController = segue.destination as! DetalleUnidadDeAprendizajeTableViewController
                destinationViewController.unidadDeAprendizaje = uaSel
                
            }
        }
    }
    
}
