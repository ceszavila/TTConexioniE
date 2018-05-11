//
//  GestionarViewController.swift
//  Movilidad2
//
//  Created by Ivo Sam on 5/6/18.
//  Copyright © 2018 Ivo Sam. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class GestionarViewController: UIViewController {
    
    //MARK:- VARIABLES
    var fireDB: DatabaseReference!
    var rowSelected: Int?
    var sectionSelected: Int?
    var movilidadFecha = [Int]()
    var responseDB: [String:[String:String]]?
    var willEdit: Bool = false
    var willAdd: Bool = false
    var movilidad = [
        Formulario(tipo: "Nacional"),
        Formulario(tipo: "Internacional"),
        Formulario(tipo:"Posgrado"),
        
        ]
    //MARK: - OUTLETS
    @IBOutlet var gestionarConvocatoriasTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        gestionarConvocatoriasTableView.delegate = self
        gestionarConvocatoriasTableView.dataSource = self
        
        //Se crea la referencia a la base de datos
        fireDB = Database.database().reference()
        
        //Se hace la consulta directa a la base de datos en firebase y trae todo
        fireDB.observeSingleEvent(of: DataEventType.value) { (aDataSnapShot) in
            if let keys = aDataSnapShot.value as? [String: [String: String]]{
                
                self.responseDB = keys
                for key in keys{
                    //Se agregan a al arreglo los años registrados en la base de datos.
                    self.movilidadFecha.append(Int(key.key)!)
                }
                //Se ordena de mayor a menenor o de menor a mayor
                self.movilidadFecha.sort{$0>$1}
                //Vuelve a cargar la tabla
                self.gestionarConvocatoriasTableView.reloadData()
            }
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func agregarBtn(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showEditarConvocatoria", sender: self)
    }
    
    @IBAction func salirBtn(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
        navigationController?.popToRootViewController(animated: true)
            
        }
        catch {
            print("there was a problem signing out.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ConvocatoriaViewController{
            destination.isAddingConv = self.willAdd
            destination.isEditingConv = self.willEdit
            if self.willEdit{
                let arrRowValue = movilidad[rowSelected!].tipo
                let arrSectionValue = movilidadFecha[sectionSelected!]
                if let aResponse = responseDB, let yearValue = aResponse["\(arrSectionValue)"], let url = yearValue[arrRowValue]{
                    print(url)
                    destination.strAño = "\(arrSectionValue)"
                    destination.strNacional = yearValue["Nacional"]
                    destination.strInternacional = yearValue["Internacional"]
                    destination.strPosgrado = yearValue["Posgrado"]
                }

            }
        }
    }
}
//MARK:- EXTENSIONS
extension GestionarViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return movilidadFecha.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "\(movilidadFecha[section])"
        label.backgroundColor = UIColor.lightGray
        label.textAlignment = .center
        return label
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movilidad.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = movilidad[indexPath.row].tipo.capitalized

        //Aquí se valida que sección es, anteriormente ordené las secciones por año, si es la sección 0 es el año en curso.
        if indexPath.section == 0{
  //          cell.backgroundColor = UIColor.green
            let a = UIImageView.init(frame: (CGRect(x: 380, y: 12, width: 20, height: 20)))
            a.image = UIImage.init(named: "green")!
            cell.addSubview(a)
        }else{
  //          cell.backgroundColor = UIColor.red
            let b = UIImageView.init(frame: (CGRect(x: 380, y: 12, width: 20, height: 20)))
            b.image = UIImage.init(named: "red")!
            cell.addSubview(b)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sectionSelected = indexPath.section
        rowSelected = indexPath.row
        self.willEdit = true
        self.willAdd = false
        performSegue(withIdentifier: "showEditarConvocatoria", sender: self)
    }
}
