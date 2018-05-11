//
//  ConvocatoriaViewController.swift
//  Movilidad2
//
//  Created by Luis Genaro Arvizu Vega on 08/05/18.
//  Copyright © 2018 Ivo Sam. All rights reserved.
//

import UIKit
import FirebaseDatabase
class ConvocatoriaViewController: UIViewController {

    //    MARK: - VARIABLES
    var isEditingConv: Bool = false
    var isAddingConv: Bool = false
    var fireDB: DatabaseReference!
    var responseDB: [String:[String:String]]?
    var strNacional: String?
    var strInternacional: String?
    var strPosgrado: String?
    var strAño: String?
    //    MARK: - OUTLETS
    
    @IBOutlet weak var tfNacional: UITextField!
    @IBOutlet weak var tfInternacional: UITextField!
    @IBOutlet weak var tfAño: UITextField!
    @IBOutlet weak var tfPosgrado: UITextField!
    
    var btnBar:UIBarButtonItem?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isAddingConv{
            btnBar = UIBarButtonItem(title: "Agregar", style: UIBarButtonItemStyle.plain, target: self, action: #selector(actAgregar))
            self.navigationItem.rightBarButtonItem = btnBar!
        }else{
            self.navigationItem.hidesBackButton = true
            btnBar = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(actTerminar))
            self.navigationItem.leftBarButtonItem = btnBar!
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Se crea la referencia a la base de datos
        fireDB = Database.database().reference()
        
        if isEditingConv{
            tfAño.text = strAño
            tfNacional.text = strNacional
            tfPosgrado.text = strPosgrado
            tfInternacional.text = strInternacional
        }
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - ACTIONS
    @objc func actAgregar(){
        let dicConv = ["Nacional":tfNacional.text!, "Posgrado":tfPosgrado.text!, "Internacional": tfInternacional.text!]
        self.fireDB.child("\(tfAño.text!)").setValue(dicConv)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func actTerminar(){
        let dicConv = ["Nacional":tfNacional.text!, "Posgrado":tfPosgrado.text!, "Internacional": tfInternacional.text!]
        self.fireDB.child("\(tfAño.text!)").setValue(dicConv)
        self.navigationController?.popViewController(animated: true)
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
