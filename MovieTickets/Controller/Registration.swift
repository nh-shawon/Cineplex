//
//  Registration.swift
//  MovieTickets
//
//  Created by Nazirul Hasan on 25/11/19.
//  Copyright © 2019 Nazirul Hasan. All rights reserved.
//

import UIKit
import Firebase

class Registration: UIViewController {

    @IBOutlet weak var uname: UITextField!
    @IBOutlet weak var uemail: UITextField!
    @IBOutlet weak var upass: UITextField!
    @IBOutlet weak var ucpass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func register(_ sender: Any) {
        
        if uname.text!.isEmpty || uemail.text!.isEmpty || upass.text!.isEmpty || ucpass.text!.isEmpty {
            let alertController = UIAlertController(title: "Oooops", message:
                "Please fill out the Information", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        else if upass.text != ucpass.text {
            let alertController = UIAlertController(title: "Oooops", message:
                "Both Passwords must be same!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            Auth.auth().createUser(withEmail: uemail.text!, password: upass.text!) { (user, error) in
                if (error != nil) {
                    let alertController = UIAlertController(title: "Oooops", message:
                       "\(error!)", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
                else {
                    let alertController = UIAlertController(title: "Yeeeeyy", message:
                        "Registration Successfull!", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                    self.performSegue(withIdentifier: "goToContentFromReg", sender: self)
                }
            }
        }
        
    }
    
    
}
