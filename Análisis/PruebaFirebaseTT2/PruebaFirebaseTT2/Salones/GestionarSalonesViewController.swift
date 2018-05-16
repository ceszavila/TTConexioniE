//
//  GestionarSalonesViewController.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 26/03/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase

var refSalon : DatabaseReference!


class GestionarSalonesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var salonTabla: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSalon", for: indexPath) as! SalonesTableViewCell
        let salon : Salon
        
        salon = salonList[indexPath.row]
        cell.nombreSalon.text = salon.nombreSalon
        
        return cell
    }
    
    var salonList = [Salon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        refSalon = Database.database().reference().child("salones");
        refSalon.observe(DataEventType.value){ (snapshot) in
            if snapshot.childrenCount>0{
                self.salonList.removeAll()
                
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
                    
                    self.salonList.append(salon)
                    print(self.salonList)
                }
            }
            self.salonTabla.reloadData()
        }
        // Do any additional setup after loading the view.
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

}
