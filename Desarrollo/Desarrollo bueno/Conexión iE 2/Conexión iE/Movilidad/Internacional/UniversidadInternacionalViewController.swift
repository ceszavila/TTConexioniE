//
//  UniversidadInternacionalViewController.swift
//  Conexión iE
//
//  Created by Cesar Avila on 24/05/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase
import WebKit
class UniversidadInternacionalViewController: UIViewController {

    @IBOutlet weak var universidad: WKWebView!
    var movilidadInternacional : MovilidadInternacional!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Universidades"
        print("\(movilidadInternacional.universidad!)")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let direccion : String = "\(self.movilidadInternacional.universidad!)"
        print(direccion)
        let url : URL = URL(string: direccion)!
        let urlRequest : URLRequest = URLRequest(url: url)
        universidad.load(urlRequest)
    }
}
