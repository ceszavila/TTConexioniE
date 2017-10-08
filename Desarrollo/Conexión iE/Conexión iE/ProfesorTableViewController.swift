//
//  ProfesorTableViewController.swift
//  Conexión iE
//
//  Created by Cesar Avila on 08/10/17.
//  Copyright © 2017 Cesar Avila. All rights reserved.
//

import UIKit

class ProfesorTableViewController: UITableViewController {
    @IBOutlet var profesorTabla: UITableView!
    var profesores : [Profesor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var profesor = Profesor(nombre: "Ulises Vélez Saldaña",
                                fotografia: #imageLiteral(resourceName: "ulises"),
                                cubiculo: "2103",
                                email: "ulises.velez-ipn@gmail.com",
                                telefono: "5532465432",
                                paginaWeb: "http://www.ulises.com",
                                horarioAtencion:["Lunes:15:00 - 16 :00","Martes:15:00-16:00"])
        profesores.append(profesor)
        
        profesor = Profesor(nombre: "José David Ortega Pachecho",
                            fotografia: #imageLiteral(resourceName: "david"),
                            cubiculo: "2103",
                            email: "dadvid82@gmail.com",
                            telefono: "5532462892",
                            paginaWeb: "http://www.david.com",
                            horarioAtencion:["Miercoles:15:00 - 16 :00","Viernes:15:00-16:00"])
        profesores.append(profesor)
        
        profesor = Profesor(nombre: "José Jaime López Rabadán",
                            fotografia: #imageLiteral(resourceName: "rabadan"),
                            cubiculo: "2103",
                            email: "jrabadan@gmail.com",
                            telefono: "55324628002",
                            paginaWeb: "http://www.rabadan.com",
                            horarioAtencion:["Lunes:08:00-10:00"])
        profesores.append(profesor)
        
        profesor = Profesor(nombre: "Hermes Francsico Montes Casiano",
                            fotografia: #imageLiteral(resourceName: "hermes"),
                            cubiculo: "2103",
                            email: "hermes.montes@gmail.com",
                            telefono: "553242892",
                            paginaWeb: "http://www.hermesmontes.com",
                            horarioAtencion:["Miercoles:15:00 - 16 :00","Viernes:15:00-16:00"])
        profesores.append(profesor)
        
        
    }
    // Ocultar la barr de navegación cuando deslizamos la pantala
    
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

    // FUNCION PARA INDICAR CUANTAS SECCIONES TENDRA NUESTRA TABLA
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // FUNCIÓN QUE INDICA, DADA UNA SECCION CUANTAS FILAS TIENE QUE CONTEENR
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.profesores.count
    }

    // FUNCIÓN QUE HACE QUE APAREZCAN EN LA PANTALLA TODAS Y CADA UNA DE LAS CELDAS
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // EL CÓDIGO DE AQUI ABAJO INDICA EN QUE FILA ME ENCUENTRO Y EN CONSECUENCIA, BUECA EN EL ARRAY CUAL DE LOS PROFESORES DEBE SER EL QUE BUSQUÉ
        
        let profesor = profesores[indexPath.row] // ESTA FUNCION NOS DICE EN QUE FILA DE LA TABLA ME ENCUENTRO, Y EN CONSECUENCIA BUSCAR EN EL ARRAY CUAL PROFESOR ES EN LA QUE ESTOY
        
        
        //PARA CONFIGURAR LA CELDA EN EL STORYBOARD EN EL ATRIBUTES INSPECTOR PONERLE UN IDENTIFICADOR A LA TABLA
        let idCelda = "ProfesorCelda"
        let cell = tableView.dequeueReusableCell(withIdentifier: idCelda, for: indexPath)
            cell.textLabel?.text = profesor.nombre
            cell.imageView?.image = profesor.fotografia
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

}
