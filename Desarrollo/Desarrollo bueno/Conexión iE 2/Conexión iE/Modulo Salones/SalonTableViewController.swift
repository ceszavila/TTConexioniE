//
//  SalonTableViewController.swift
//  Conexión iE
//
//  Created by Cesar Avila on 15/10/17.
//  Copyright © 2017 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase
class SalonTableViewController: UITableViewController {
    @IBOutlet var salonTableView: UITableView!
    var salonesList: [Salon] = []
    var refSalones : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Asginación de grupos"
        refSalones = Database.database().reference().child("salones");
        refSalones.queryOrdered(byChild: "grupo_salon").observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount>0{
                self.salonesList.removeAll()
                for salon in snapshot.children.allObjects as! [DataSnapshot]{
                    let salonObjet = salon.value as? [String:AnyObject]
                    let salonGrupo = salonObjet!["grupo_salon"]
                    let salonId = salonObjet!["id_salon"]
                    let salonImagenAerea = salonObjet!["imagenaerea_salon"]
                    let salonImagenNivel = salonObjet!["imagennivel_salon"]
                    let salonLatitud = salonObjet!["latitud_salon"]
                    let salonLongitud = salonObjet!["longitud_salon"]
                    let salonNombre = salonObjet!["nombre_salon"]
                    let salonNumeroEdificio = salonObjet!["numero_edificio"]
                    
                    let salon = Salon(nombreSalon: salonNombre as! String, grupo: salonGrupo as! String, numeroEdificio: salonNumeroEdificio as! String, latitudSalon: salonLatitud as! String, longitudSalon: salonLongitud as! String, imagenNivel: salonImagenNivel as! String, imagenSalon: salonImagenAerea as! String)
                    
                    self.salonesList.append(salon)
                    print(self.salonesList)
                }
            }
            self.tableView.reloadData()
        }
    }
     //MARK: Falta poner la linea que va en el ProfesorDetalleTableViewController.swift para que desaparezca la barra
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // ESTA FUNCIÓN QUITA LA BARRA DE ESTADO AL MOMENTO DE ABRIR LA VISTA PROFESORES
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.salonesList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         // EL CÓDIGO DE AQUI ABAJO INDICA EN QUE FILA ME ENCUENTRO Y EN CONSECUENCIA, BUECA EN EL ARRAY CUAL DE LOS PROFESORES DEBE SER EL QUE BUSQUÉ
        
        let salon = salonesList[indexPath.row]
        
        
        //PARA CONFIGURAR LA CELDA EN EL STORYBOARD EN EL ATRIBUTES INSPECTOR PONERLE UN IDENTIFICADOR A LA TABLA
        let idCelda = "SalonCelda"
        
        // RECUPERAR LA CELDA QUE ESTA EN EL INDEXPATH QUE ESTAMOS CONFIGURARNDO, PARA CONFIGURAR NUESTRA CELDA DEL PROFESORCELL.SWIFT DONDE CREAMOS LA IMAGEN Y LOS LABELS DEBEMOS HACER UN PEQUEÑO CAST PARA INDICARLE EN DONDE ESTAN NUESTA CELDA PERSONALIZADA CON EL AS!
        let cell = tableView.dequeueReusableCell(withIdentifier: idCelda, for: indexPath) as! SalonCell
            cell.salonGrupo.text = salon.grupo
            cell.nombreGrupo.text = salon.nombreSalon
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // PROGRAMAR PARA QUE EL SEGUE PASE SABIENDO QUE CELDA ESTA PULSADA, EK SEGUE PASA A LA OTRA VISTA
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //NOS ASEGURAMOS QUE SI SEA EL SEGUE QUE QUEREMOS CON E IDENTIFICADOR QUE LE PUSIMOS AL SEGUE
        if segue.identifier == "DetalleSalon"{
            // AHORA HAY QUE DECIRLE QUE CELDA HA SIDO SELECCIONADA Y RECUPERAR EL INDEXPATH SELECCIONADO
            // EN CASE DE QUE EL INDEXPAH SELECCIONADO EN CONCRETO, VA A SER UNA VARIABLE ASGINDA DE TIPO INDEXPATH, SI NO SE SELECCIONA NADA ESTA VARIABLE SERA NULA Y NO SE EJECUTARA ESTE SEGMENTO DE CODIGO
            if let indexpath = self.tableView.indexPathForSelectedRow{
                // SELECCIONAMOS AL PROFESOR
                let salonseleccionado = self.salonesList[indexpath.row]
                // DECIR QUIEN ES EL VIEWCONTROLLER DE DESTIONO Y ESTO LO SABE EL SEGUE CON EL DESTINATITON ASI QUE TENEMOS QUE HACER UN CASTING Y ASIGNAR LA VARIABLE PROFESOR QUE SE CREO EN EL DETALLESPROFESOR.SWIFT TIENE QUE SER NI MAS NI MENOS QUE EL PROFESOR SELEECIONADO DEL INDEXPATH QUE HA LLEGADO
                let destinationViewController = segue.destination as! DetallesSalonViewController
                destinationViewController.salon = salonseleccionado
                
            }
        }
    }
}
