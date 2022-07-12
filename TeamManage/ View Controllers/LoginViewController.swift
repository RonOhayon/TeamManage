//
//  LoginViewController.swift
//  TeamManage
//
//  Created by user216780 on 7/6/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var teamCodeField: UITextField!
    @IBOutlet var sgininButtom: UIButton!
    @IBOutlet var signUpButton: UIButton!
    
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

    @IBAction func sginInTapped(_ sender: Any) {
        
        // vailidate text fields
        let error = vaildateFields()
        
        if error != nil{
            alart(message: error!)
            
        }else{
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let teamCode = teamCodeField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if error != nil{
                    //Couldn't sgin in
                    self.alart(message: "user was not found")
                }else{
                    self.transitionToHome()
                }
            }
        }
        
        //sigin in the user
    }
    
    func vaildateFields()-> String?{
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            teamCodeField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill all fields."
        }
        let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordVaild(password: cleanPassword) == false{
            return "Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character"
        }
        
        return nil
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
    
    func transitionToHome(){
        let homeViewController =
        storyboard?.instantiateViewController(withIdentifier:
        Constants.Storyboard.HomeViewController) as?
        HomeViewController
        view.window?.rootViewController = homeViewController
         
        view.window?.makeKeyAndVisible()
    }
}
