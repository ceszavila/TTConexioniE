//
//  LogInViewController.swift
//  Movilidad2
//
//  Created by Ivo Sam on 5/6/18.
//  Copyright © 2018 Ivo Sam. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwdTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logInPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        let user = emailTextField.text!
        let password = passwdTextField.text!
        
        if user.isEmpty || password.isEmpty {
            errMessage()
        }
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwdTextField.text!) { (user, error) in
            
            if error != nil {
                print(error!)
                
                SVProgressHUD.dismiss()
                
                self.errMessage()
                
            } else {
                print("Log In successful!")
                
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToConvocatorias", sender: self)
            }
            
        }
        
    }
    
    //Mensaje de error cuando no es correcto el usuario o contraseña
    func errMessage() {
        let alert = UIAlertController(title: "Error", message: "Usuario y/o contraseña incorrecta", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
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
