//
//  MovilidadViewController.swift
//  Conexión iE
//
//  Created by Cesar Avila on 24/05/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase

var refMovilidadInternacional : DatabaseReference!
var refMovilidadNacional : DatabaseReference!

class MovilidadViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    @IBOutlet weak var internacionaltbl: UITableView!
    @IBOutlet weak var nacionaltbl: UITableView!
    
    var interList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movilidad Estudiantil"
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
