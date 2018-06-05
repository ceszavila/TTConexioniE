//
//  GestionarMovilidadViewController.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 16/05/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase

var refInternacional : DatabaseReference!
var refNacional : DatabaseReference!


class GestionarMovilidadViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
  
    @IBOutlet weak var internacionaltbl: UITableView!
    @IBOutlet weak var nacionaltbl: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView==nacionaltbl){
        return nacionalList.count
        }else{
        return interList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if (tableView==nacionaltbl){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellNacional", for: indexPath) as! MovilidadNacionalTableViewCell
            let nacional : MovilidadNacional
            
            nacional = nacionalList[indexPath.row]
            let periodo = nacional.periodoN
            let ano = nacional.anoN
        cell.nombreNacional.text = (periodo)! + " \(ano!)"
        return cell
       } else{
       
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellInternacional", for: indexPath) as! MovilidadInternacionalTableViewCell
            let internacional : MovilidadInternacional
            internacional = interList[indexPath.row]
            let periodo = internacional.periodo
            let ano = internacional.ano
            cell.nombreInternacional.text = periodo! + " \(ano!)"
            return cell
    }
    }
    
    var interList = [MovilidadInternacional]()
    var nacionalList = [MovilidadNacional]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movilidad Estudiantil"
        
        refInternacional = Database.database().reference().child("internacional");
        refInternacional.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount>0{
                self.interList.removeAll()
                
                for internacional in snapshot.children.allObjects as! [DataSnapshot]{
                    let internacionalObject = internacional.value as? [String:AnyObject]
                    let internacionalPeriodo = internacionalObject!["periodo_internacional"]
                    let internacionalId = internacionalObject!["id_internacional"]
                    let internacionalAno = internacionalObject!["ano_internacional"]
                    let internacionalUniversidad = internacionalObject!["universidad_internacional"]
                    let internacionalConvocatoria = internacionalObject!["convocatoria_internacional"]
                    let internacionalResultado = internacionalObject!["resultado_internacional"]
                    
                    let movilidadInternacional = MovilidadInternacional(idInternacional: internacionalId as! String, periodo: internacionalPeriodo as! String, ano: internacionalAno as! String, universidad: internacionalUniversidad as! String, convocatoria: internacionalConvocatoria as! String, resultados: internacionalResultado as! String)
                    self.interList.append(movilidadInternacional)
                    
                }
            }
            self.internacionaltbl.reloadData()
        }
    
        refNacional = Database.database().reference().child("nacional");
        refNacional.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount>0{
                self.nacionalList.removeAll()
                
                for nacional in snapshot.children.allObjects as! [DataSnapshot]{
                    let nacionalObject = nacional.value as? [String:AnyObject]
                    let nacionalPeriodo = nacionalObject!["periodo_nacional"]
                    let nacionalId = nacionalObject!["id_nacional"]
                    let nacionalAno = nacionalObject!["ano_nacional"]
                    let nacionalUniversidad = nacionalObject!["universidad_nacional"]
                    let nacionalConvocatoria = nacionalObject!["convocatoria_nacional"]
                    let nacionalResultado = nacionalObject!["resultado_nacional"]
                    
                    let movilidadNacional = MovilidadNacional(idNacional: nacionalId as! String, periodoN: nacionalPeriodo as! String, anoN: nacionalAno as! String, universidadN: nacionalUniversidad as! String, convocatoriaN: nacionalConvocatoria as! String, resultadosN: nacionalResultado as! String)
                    
                    self.nacionalList.append(movilidadNacional)
                    
                    print(self.nacionalList)
                }
            }
           
            self.nacionaltbl.reloadData()
        }
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //NOS ASEGURAMOS QUE SI SEA EL SEGUE QUE QUEREMOS CON E IDENTIFICADOR QUE LE PUSIMOS AL SEGUE
        switch segue.identifier{
        case "visualizarMovilidadNacional"?:
            if let indexpath = self.nacionaltbl.indexPathForSelectedRow{
                let movilidadNacionalSeleccionada = self.nacionalList[indexpath.row]
            
                let destinationViewController = segue.destination as! VisualizarMovilidadViewController
                destinationViewController.movilidadNacional = movilidadNacionalSeleccionada
            }
        case "visualizarMovilidadInternacional"?:
                
                if let indexpath = self.internacionaltbl.indexPathForSelectedRow{
                  
                    let movilidadInternacionalSeleccionada = self.interList[indexpath.row]
                    
                    let destinaViewController = segue.destination as!   VisualizarMovilidadInternacionalViewController
                    destinaViewController.movilidadInternacional = movilidadInternacionalSeleccionada
                }
                
        default:
            break
        }
        }
}
