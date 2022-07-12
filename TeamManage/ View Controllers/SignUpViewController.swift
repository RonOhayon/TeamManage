//
//  SignUpViewController.swift
//  TeamManage
//
//  Created by user216780 on 7/6/22.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordOneTextField: UITextField!
    @IBOutlet var teamCodeTextField: UITextField!
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    
    func vaildateFields()-> String?{
        //Check that all fields are filled in
        if firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordOneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            teamCodeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill all fields."
        }
        let cleanPassword = passwordOneTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordVaild(password: cleanPassword) == false{
            return "Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character"
        }
    
        
       
        return nil
    }
    @IBAction func signUpTapped(_ sender: Any) {
        //Validate the fields
        let error = vaildateFields()
        
        if error != nil{
            alart(message: error!)
        }else{
            // clean data
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordOneTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let firstName = firstNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let teamCode = teamCodeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //check for errors
                if err != nil{
                    self.alart(message: "Error createing a user")
                }
                else{
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname":firstName,
                                                              "lastname":lastName,
                                                              "uid":result!.user.uid,
                                                              "teamcode":teamCode]) {(error) in
                        if error != nil {
                            self.alart(message: "error to save data")
                        }
                    }
                  // Transition to home screen
                    let name = firstName + "  " + lastName
                    self.transitionToHome(name: name)
                }
            }
            
        }
        
        
    }
    
    func transitionToHome(name: String){
        let homeViewController =
        storyboard?.instantiateViewController(withIdentifier:
        Constants.Storyboard.HomeViewController) as?
        HomeViewController
        view.window?.rootViewController = homeViewController
        
        view.window?.makeKeyAndVisible()
    }
    
    func alart(message: String){
        let alart = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alart.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alart, animated: true)
    }
    
    func isPasswordVaild(password: String)-> Bool{
        let passwordTast = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$")
        return passwordTast.evaluate(with: password)
    }
    
}
