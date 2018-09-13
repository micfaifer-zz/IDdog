//
//  SignUpViewController.swift
//  IDdog
//
//  Created by lugia on 11/09/18.
//  Copyright © 2018 MicFaifer. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    let dogFeedSegueIdentifier = "dogFeedSegue"

    let signUpService = SignUpService()

    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!

    @IBAction func signUp(_ sender: UIButton) {
        if emailTextField.text == "" {
            self.alert(message: "Preencha o campo de email")
        } else if let email = emailTextField.text {
            signUpService.signUp(emailAddress: email) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let signUpResult):
                        //go to feed view controller
                        self.performSegue(withIdentifier: self.dogFeedSegueIdentifier, sender: signUpResult.user)
                        print(signUpResult)
                    case .failure(let error):
                        self.alert(message: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == dogFeedSegueIdentifier, let user = sender as? User {
            if let dogFeedVC = segue.destination as? DogFeedViewController {
                dogFeedVC.user = user
            }
        }
    }
}

