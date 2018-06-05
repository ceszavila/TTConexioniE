//
//  ProfesorTableViewController.swift
//  Conexión iE
//
//  Created by Cesar Avila on 08/10/17.
//  Copyright © 2017 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase

class ProfesorTableViewController: UITableViewController {
    @IBOutlet var profesorTabla: UITableView!
    var profesoresList : [Profesor] = []
    var refProfesor : DatabaseReference!
    var imageReference : StorageReference {
      return Storage.storage().reference().child("PROFESORES")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Agenda de profesores"
        refProfesor = Database.database().reference().child("profesores version FireStorage");
        refProfesor.queryOrdered(byChild: "nombre_profesor").observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount>0{
                self.profesoresList.removeAll()
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
                    
                    let profesor = Profesor(nombre: profesorNombre as! String, fotografia: profesorFotografia as! String, cubiculo: profesorCubiculo as! String, email: profesorCorreo as! String, telefono: profesorTelefono as! String, paginaWeb: profesorPagina as! String, horarioAtencion: profesorCubiculo as! String, academia: profesorAcademia as! String, materias: profesorMateria as! String, trabajoTerminal: profesorTT as! String)
                    
                    self.profesoresList.append(profesor)
                    print(self.profesoresList)
                }
            }
            self.profesorTabla.reloadData()
        }
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
        return self.profesoresList.count
    }

    // FUNCIÓN QUE HACE QUE APAREZCAN EN LA PANTALLA TODAS Y CADA UNA DE LAS CELDAS
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // EL CÓDIGO DE AQUI ABAJO INDICA EN QUE FILA ME ENCUENTRO Y EN CONSECUENCIA, BUECA EN EL ARRAY CUAL DE LOS PROFESORES DEBE SER EL QUE BUSQUÉ
        
        let profesor = profesoresList[indexPath.row]
        
        
        //PARA CONFIGURAR LA CELDA EN EL STORYBOARD EN EL ATRIBUTES INSPECTOR PONERLE UN IDENTIFICADOR A LA TABLA
        let idCelda = "ProfesorCelda"
        
        // RECUPERAR LA CELDA QUE ESTA EN EL INDEXPATH QUE ESTAMOS CONFIGURARNDO, PARA CONFIGURAR NUESTRA CELDA DEL PROFESORCELL.SWIFT DONDE CREAMOS LA IMAGEN Y LOS LABELS DEBEMOS HACER UN PEQUEÑO CAST PARA INDICARLE EN DONDE ESTAN NUESTA CELDA PERSONALIZADA CON EL AS!
        let cell = tableView.dequeueReusableCell(withIdentifier: idCelda, for: indexPath) as! ProfesorCell
            cell.nombreProfesor.text = profesor.nombre
            cell.cubiculoProfesor.text = "Cubículo: \(profesor.cubiculo!)"
        
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
        
           //
        
        // Configure the cell...

        return cell
    }
    
    // ESTE MÉTODO QUE NOS DEJA AÑADIR ACCIONES AL DESLIZAR UNA FILA DE LA TABLA
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // AGREGANDO LA OPCION DE COMPARTIR A LA FILA
        let shareAction = UITableViewRowAction(style: .normal, title: "Compartir") { (action, indexPath) in
            
            // USAREMOS UN ACTIVITYVIEWCONTROLLER PARA PODER COMPARTIR
            
            let shareDefaultText = "Te he compartido al profesor : \(self.profesoresList[indexPath.row].nombre!) de la Aplicación Conexión iE"
            
            // Añadir o mostrarlo al usuario
            
            /* The UIActivityViewController class is a standard view controller that you can use to offer various services from your application. The system provides several standard services, such as copying items to the pasteboard, posting content to social media sites, sending items via email or SMS, and more.
             */
            
            
            let activityController = UIActivityViewController(activityItems: [shareDefaultText,  self.profesoresList[indexPath.row].fotografia!], applicationActivities: nil)
            
            // presentar el activity controller en pantalla
            
            self.present(activityController, animated: true , completion: nil)
        }
        
        // cambiando o eligiendo el color del botón de compartir
        shareAction.backgroundColor = UIColor(displayP3Red: 30.0/255.0, green: 164.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        
        return [shareAction]
        
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
    
    // PROGRAMAR PARA QUE EL SEGUE PASE SABIENDO QUE CELDA ESTA PULSADA, EL SEGUE PASA A LA OTRA VISTA
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //NOS ASEGURAMOS QUE SI SEA EL SEGUE QUE QUEREMOS CON E IDENTIFICADOR QUE LE PUSIMOS AL SEGUE
        if segue.identifier == "DetalleProfesor"{
            // AHORA HAY QUE DECIRLE QUE CELDA HA SIDO SELECCIONADA Y RECUPERAR EL INDEXPATH SELECCIONADO
            // EN CASE DE QUE EL INDEXPAH SELECCIONADO EN CONCRETO, VA A SER UNA VARIABLE ASGINDA DE TIPO INDEXPATH, SI NO SE SELECCIONA NADA ESTA VARIABLE SERA NULA Y NO SE EJECUTARA ESTE SEGMENTO DE CODIGO
            if let indexpath = self.tableView.indexPathForSelectedRow{
                // SELECCIONAMOS AL PROFESOR
                let profesorseleccionado = self.profesoresList[indexpath.row]
                // DECIR QUIEN ES EL VIEWCONTROLLER DE DESTINO Y ESTO LO SABE EL SEGUE CON EL DESTINATITON ASI QUE TENEMOS QUE HACER UN CASTING Y ASIGNAR LA VARIABLE PROFESOR QUE SE CREO EN EL DETALLESPROFESOR.SWIFT TIENE QUE SER NI MAS NI MENOS QUE EL PROFESOR SELEECIONADO DEL INDEXPATH QUE HA LLEGADO
                let destinationViewController = segue.destination as! DetallesProfesoresViewController
                destinationViewController.profesor = profesorseleccionado
                
            }
        }
    }
}
