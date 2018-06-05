//
//  VerMasProfesorViewController.swift
//  Conexión iE
//
//  Created by Cesar Avila on 29/10/17.
//  Copyright © 2017 Cesar Avila. All rights reserved.
//

import UIKit

class VerMasProfesorViewController: UIViewController {
  
    @IBOutlet weak var materiasLabel: UILabel!
    @IBOutlet weak var materiasTabla: UITableView!
    var profesor : String!
    var materias : [String] = []
    var trabajoTerminal : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
       self.title = profesor
        for _ in materias{
        self.materiasLabel.text = "\(materias)"
        }
        print("\(materias)")
        print("___________________")
        print("\(trabajoTerminal)")
        print("_____________________")
        
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
extension VerMasProfesorViewController : UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.materias.count
        default:
            return self.trabajoTerminal.count
        }
    }
    // MateriaSeleccionada
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MateriaSeleccionada", for: indexPath) as! MateriasCell
       return cell
    }
    
    
}
