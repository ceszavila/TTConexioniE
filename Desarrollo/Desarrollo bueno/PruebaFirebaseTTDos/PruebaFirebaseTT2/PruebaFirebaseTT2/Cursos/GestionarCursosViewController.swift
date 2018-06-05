//
//  GestionarCursosViewController.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 20/05/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase
var refCursos : DatabaseReference!

class GestionarCursosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    @IBOutlet weak var cursostbl: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cursosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cursosCell", for: indexPath) as! CursosTableViewCell
        let cursos : Curso
        cursos = cursosList[indexPath.row]
        cell.nombreCurso.text = cursos.nombreCurso!
        return cell
    }
    
    var cursosList = [Curso]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refCursos = Database.database().reference().child("cursos");
        refCursos.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount>0{
                self.cursosList.removeAll()
                
                for cursos in snapshot.children.allObjects as! [DataSnapshot]{
                    let cursosObject = cursos.value as? [String:AnyObject]
                    let idCurso = cursosObject!["id_curso"]
                    let nombreCurso = cursosObject!["nombre_curso"]
                    let descripcionCurso = cursosObject!["descripcion_curso"]
                    let requisitoCurso = cursosObject!["requisito_curso"]
                    let fechaInicioCurso = cursosObject!["fechaInicio_curso"]
                    let fechaFinCurso = cursosObject!["fechaFin_curso"]
                    let costoCurso = cursosObject!["costo_curso"]
                    let costoIPNCurso = cursosObject!["costoIPN_curso"]
                    let urlCursoObject = cursosObject!["url_curso"]
                    
                    let cursos = Curso(idCurso: idCurso as! String, nombreCurso: nombreCurso as! String, descripcionCurso: descripcionCurso as! String, requisitosCurso: requisitoCurso as! String, fechaInicioCurso: fechaInicioCurso as! String, fechaFinCurso: fechaFinCurso as! String, costoCurso: costoCurso as! String, costoIPNCurso: costoIPNCurso as! String, urlCurso: urlCursoObject as! String )
                    self.cursosList.append(cursos)
                    
                }
            }
            self.cursostbl.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //NOS ASEGURAMOS QUE SI SEA EL SEGUE QUE QUEREMOS CON E IDENTIFICADOR QUE LE PUSIMOS AL SEGUE
        if segue.identifier == "editarCurso"{
            // AHORA HAY QUE DECIRLE QUE CELDA HA SIDO SELECCIONADA Y RECUPERAR EL INDEXPATH SELECCIONADO
            // EN CASE DE QUE EL INDEXPAH SELECCIONADO EN CONCRETO, VA A SER UNA VARIABLE ASGINDA DE TIPO INDEXPATH, SI NO SE SELECCIONA NADA ESTA VARIABLE SERA NULA Y NO SE EJECUTARA ESTE SEGMENTO DE CODIGO
            if let indexpath = self.cursostbl.indexPathForSelectedRow{
                // SELECCIONAMOS AL PROFESOR
                let cursoseleccionado = self.cursosList[indexpath.row]
                // DECIR QUIEN ES EL VIEWCONTROLLER DE DESTINO Y ESTO LO SABE EL SEGUE CON EL DESTINATITON ASI QUE TENEMOS QUE HACER UN CASTING Y ASIGNAR LA VARIABLE PROFESOR QUE SE CREO EN EL DETALLESPROFESOR.SWIFT TIENE QUE SER NI MAS NI MENOS QUE EL PROFESOR SELEECIONADO DEL INDEXPATH QUE HA LLEGADO
                let destinationViewController = segue.destination as! EditarViewController
                destinationViewController.cursos = cursoseleccionado
                
            }
        }
    }

    

}
