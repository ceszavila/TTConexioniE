//
//  DetalleUnidadDeAprendizajeTableViewController.swift
//  Conexión iE
//
//  Created by Cesar Avila on 07/04/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import WebKit
import Firebase

class DetalleUnidadDeAprendizajeTableViewController: UIViewController {

    @IBOutlet weak var programaUA: WKWebView!
    @IBOutlet weak var academiaUA: UILabel!
    @IBOutlet weak var tipoUA: UILabel!
    @IBOutlet weak var nombreUA: UILabel!
    
    var unidadDeAprendizaje : UnidadDeAprendizaje!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Consultar Unidad de Aprendizaje"
        nombreUA.text = self.unidadDeAprendizaje.nombreUA
        tipoUA.text = self.unidadDeAprendizaje.tipo
        academiaUA.text = self.unidadDeAprendizaje.academia
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var direccion : String = "\(self.unidadDeAprendizaje.programaAcademico!)"
        print(direccion)
        let url : URL = URL(string: direccion)!
        let urlRequest : URLRequest = URLRequest(url: url)
        programaUA.load(urlRequest)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

 

}
