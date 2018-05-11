//
//  ConsultarViewController.swift
//  Movilidad2
//
//  Created by Ivo Sam on 5/6/18.
//  Copyright © 2018 Ivo Sam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import PDFKit

class ConsultarViewController: UIViewController {
    //    MARK: - VARIABLES
    var strURL: String?
    var movilidad : Formulario?
    private var pdfDocument: PDFDocument?
    //    MARK: - OUTLETS
    @IBOutlet var tipoImageView: UIImageView!
    var pdfView: PDFView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //strURL = "https://maestria.citedi.mx/portal/files/MCSD-Convocatoriaagosto2018.pdf"
        let urlSession: URLSession = URLSession.shared
        
        let screenSize:CGSize = UIScreen.main.bounds.size
        pdfView = PDFView(frame: CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.height)!, width: screenSize.width, height: screenSize.height))
        //self.view.addSubview(pdfView)
        if let str = strURL, let url = URL(string: str){
            let urlRequest: URLRequest = URLRequest.init(url: url)
            urlSession.dataTask(with: urlRequest) { (aData, aResponse, aError) in
                guard aError == nil else{
                    print(aError)
                    return
                }
                self.pdfDocument = PDFDocument(data: aData!)
                self.pdfView.document = self.pdfDocument
                self.pdfView.displaysAsBook = true
                self.pdfView.page
                self.pdfView.displayMode = PDFDisplayMode.singlePage
                self.pdfView.autoScales = true
                self.pdfView.displayBox = PDFDisplayBox.artBox
                self.view.addSubview(self.pdfView)
            }.resume()
           
        }else{
            print("No es valido")
        }
        
        // Do any additional setup after loading the view.
        
        tipoImageView.layer.cornerRadius = 24
//        navigationItem.title = movilidad?.tipo.capitalized
//        navigationController?.navigationBar.prefersLargeTitles = true
        tipoImageView.image = movilidad?.imagen
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
