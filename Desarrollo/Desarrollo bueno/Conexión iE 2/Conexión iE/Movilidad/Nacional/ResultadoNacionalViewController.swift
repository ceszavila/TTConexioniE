//
//  ResultadoNacionalViewController.swift
//  Conexión iE
//
//  Created by Cesar Avila on 24/05/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase
import WebKit
class ResultadoNacionalViewController: UIViewController {
    @IBOutlet weak var resultado: WKWebView!
    
     var movilidadNacional : MovilidadNacional!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Resultados"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let direccion : String = "\(self.movilidadNacional.resultadosN!)"
        print(direccion)
        let url : URL = URL(string: direccion)!
        let urlRequest : URLRequest = URLRequest(url: url)
        resultado.load(urlRequest)
    }

}
