//
//  ViewController.swift
//  CleanSwiftboilerplate
//
//  Created by Farhan Amjad on 24.06.21.
//

import UIKit
import Combine

protocol LoginVCDisplayLogic: class {

}

class LoginVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    @IBAction func loginAction(_ sender: Any) {
    
    }
}

