//
//  DetallesProfesoresViewController.swift
//  Conexión iE
//
//  Created by Cesar Avila on 08/10/17.
//  Copyright © 2017 Cesar Avila. All rights reserved.
//

import UIKit

class DetallesProfesoresViewController: UIViewController {
    @IBOutlet weak var fotoProfesorDetalle: UIImageView!
    @IBOutlet weak var academiaProfesor: UILabel!
    @IBOutlet weak var profesortableView: UITableView!
    @IBOutlet weak var nombreProfesorDetalle: UILabel!
    @IBOutlet weak var menuProfesor: UISegmentedControl!
    
    
    var profesor : Profesor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // PONIENDO EL TITULO DE LA BARRA DE NAVEGACIÓN EL NOMBRE DEL PROFESOR
            self.title = self.profesor.nombre!
            // HACER QUE LA FOTO DEL PROFESOR Y NOMBRE Y ACADEMIA TENGAN ASIGANDA POR DEFECTO LA IMAGEN Y NOMBRE DEL PROFESOR
            
        if let fotoProfesor = profesor.fotografia{
           self.fotoProfesorDetalle.image = UIImage(named: fotoProfesor)
        }
            self.nombreProfesorDetalle.text = self.profesor.nombre
            self.academiaProfesor.text = self.profesor.academia
            // Do any additional setup after loading the view.
            // CAMBIANDO EL COLOR DE LA TABLA
            
            self.profesortableView.estimatedRowHeight = 44.0
            self.profesortableView.rowHeight = UITableViewAutomaticDimension
    
        
    }
    
    // TENEMOS QUE AÑADIR ESTA LINEA PARA QUE APAREZCA LA BARRA DE ESTADO CADA VEZ QUE SE LLAMA CUANDO VA A APARECER
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true) // LLAMAR PRIMERO AL SUPER
        navigationController?.hidesBarsOnSwipe = false // HACEMOS EL CASO CONTRARIO PARA QUE NO NO OCULTE LA BARRA POR QUE SI NO, NO PODEMOS VOLVER ATRAS
        navigationController?.setNavigationBarHidden(false, animated: true) // AQUI SE LE DICE A SWIFT SI ESTABA OCULTA LA BARRA APARECELA
    }
    
    // AÑADIR EL METODO PrefersStatusBarHidden:Bool{} para ocultar la barra de estado
    override var prefersStatusBarHidden:Bool{
        return true
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
    
    
    /*
     
     // PROGRAMAR PARA QUE EL SEGUE PASE SABIENDO QUE CELDA ESTA PULSADA, EK SEGUE PASA A LA OTRA VISTA
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     //NOS ASEGURAMOS QUE SI SEA EL SEGUE QUE QUEREMOS CON E IDENTIFICADOR QUE LE PUSIMOS AL SEGUE
     if segue.identifier == "DetalleProfesor"{
     // AHORA HAY QUE DECIRLE QUE CELDA HA SIDO SELECCIONADA Y RECUPERAR EL INDEXPATH SELECCIONADO
     // EN CASE DE QUE EL INDEXPAH SELECCIONADO EN CONCRETO, VA A SER UNA VARIABLE ASGINDA DE TIPO INDEXPATH, SI NO SE SELECCIONA NADA ESTA VARIABLE SERA NULA Y NO SE EJECUTARA ESTE SEGMENTO DE CODIGO
     if let indexpath = self.tableView.indexPathForSelectedRow{
     // SELECCIONAMOS AL PROFESOR
     let profesorseleccionado = self.profesores[indexpath.row]
     // DECIR QUIEN ES EL VIEWCONTROLLER DE DESTIONO Y ESTO LO SABE EL SEGUE CON EL DESTINATITON ASI QUE TENEMOS QUE HACER UN CASTING Y ASIGNAR LA VARIABLE PROFESOR QUE SE CREO EN EL DETALLESPROFESOR.SWIFT TIENE QUE SER NI MAS NI MENOS QUE EL PROFESOR SELEECIONADO DEL INDEXPATH QUE HA LLEGADO
     let destinationViewController = segue.destination as! DetallesProfesoresViewController
     destinationViewController.profesor = profesorseleccionado
     
     }
     }
     }*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController : VerMasProfesorViewController = segue.destination as! VerMasProfesorViewController
        
        DestViewController.profesor = self.profesor.nombre!
       // DestViewController.materias = self.profesor.materias!
        // DestViewController.trabajoTerminal = self.profesor.trabajoTerminal!
    }
    
}

extension DetallesProfesoresViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        // DEFINO NUMERO DE SECCIONES QUE QUIERO
        /* SON DOS SECCIONES
         1º SECCIÓN: Cubiculo
         2º SECCIÓN: HORARIO DE ATENCION
         3º SECCIÓN: MEDIOS DE CONTACTO
         4º SECCIÓN: MATERIAS
         5º SECCIÓN: TT
         */
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: // CASO PARA LA SECCION DE CUBICULO
            return 1
        case 1:
            return 1 // CASO PARA LA SECCION DE Horario
        case 2:
            return 3 // CASO PARA LA SECCION DE Telefono
        case 3:
            return 1
        case 4:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetalleProfesorSeleccionado", for: indexPath) as! ProfesorSeleccionadoDetallesTableViewCell
        // QUITANDO EL COLOR DE LAS CELDAS PERSONALIZADAS PARA QUE EL COLOR QUE DEFINIMOS ARRRIBA SEA EL QUE SE VEA
    // AHORA TENEMOS QUE HACER UN SWITCH PARA INDICAR QUE PARTES DEL CODIGO SON PARA QUE SECCION
        switch indexPath.section {
        case 0: // CASO DE SECCION 1
            // UN SWITCH DE INDEXPATH.ROW POR QUE COMO HE INDICADO QUE QUIERO 3 CELDAS ME PUEDEN LLEGAR LA 1,2 Ó 3
                        // EN LA PRIMERA CELDA DE LA TABLA SE MUESTRA EL NOMBRE
                    cell.keyLabel.text = "Cubiculo:"
                    cell.valueLabel.text = "Salón: \(self.profesor.cubiculo!)"
        case 1:
            if indexPath.row == 0{
                cell.keyLabel.text = "Horario" // SOLO EL INDEXPATH EN LA POSICIÓN NUMERO 0 MOSTRARA LA PALABRA HORARIO
            } else{
                cell.keyLabel.text = ""
            }
            // cell.valueLabel.text = self.profesor.horarioAtencion[indexPath.row]
            cell.valueLabel.text = self.profesor.horarioAtencion!
            // PONIENDO LOS Horarios
        case 2:
            switch indexPath.row {
            case 0:
                // EN LA PRIMERA CELDA DE LA TABLA SE MUESTRA EL NOMBRE
                cell.keyLabel.text = "E-mail:"
                cell.valueLabel.text = self.profesor.email!
            case 1:
                // SEGUNDA CELDA MOSTRARA EL TIEMPO
                cell.keyLabel.text = "Teléfono:"
                cell.valueLabel.text = self.profesor.telefono!
            case 2:
                 // EN LA TERCERA SE MOSTRARA SI ES FAVORITA O NO
                cell.valueLabel.isUserInteractionEnabled = true
                cell.keyLabel.text = "Página Web:"
                cell.valueLabel.text = self.profesor.paginaWeb!
            default:
                break
            }
        case 3:
            if indexPath.row == 0{
            cell.valueLabel.text = ""
            } else {
            cell.valueLabel.text = ""
            }
            // cell.keyLabel.text = self.profesor.materias[indexPath.row]
            cell.keyLabel.text = self.profesor.materias!
        case 4:
            if indexPath.row == 0{
            cell.valueLabel.text = ""
            } else{
                cell.valueLabel.text = ""
            }
            // cell.keyLabel.text = self.profesor.trabajoTerminal[indexPath.row]
             cell.keyLabel.text = self.profesor.trabajoTerminal!
        default:
            break
        }
    
    return cell
}
   // FUNCION PARA PONER TITULOS A CADA SECCION
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            title = "Puedes encontrar al profesor en ..."
        case 1:
            title = "Horario de Atención"
        case 2:
            title = "Medios de Contacto"
        case 3:
            title = "Materias Impartidas"
        case 4:
            title = "Trabajos Terminales Dirigidos"
        default:
            break
        }
        return title
    }
}


extension DetallesProfesoresViewController : UITableViewDelegate{
    
}


    

