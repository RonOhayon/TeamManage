//
//  NewTaskViewController.swift
//  TeamManage
//
//  Created by user216780 on 7/9/22.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    
   
    @IBOutlet var dateIssueField: UITextField!
    @IBOutlet var taskDataField: UITextView!
    @IBOutlet var dateTodoField: UITextField!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var titleField: UITextField!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapAdd(){
        let error = vaildateFields()
       
        if error != nil{
            alart(message: error!)
            
        }else{
            //set the data for the struct
            let title = titleField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let dateIssue = dateIssueField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let dateTodo = dateTodoField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let taskdata = taskDataField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            // set the struct
            let todo = Todo(id: "" ,name: title, dateIssue: dateIssue, dateTodo: dateTodo, note: taskdata)
            
            //send the task
            NotificationCenter.default.post(name: Notification.Name("todo"), object: todo)
            dismiss(animated: true,completion: nil)
        }
    
        
    }
    
    
    
    func vaildateFields()-> String?{
        if dateIssueField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return " please set a date issue"
        }
        if dateTodoField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return " please set a date Todo"
        }
        if taskDataField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "please set the task  "
        }
        if titleField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "please set the Title!!  "
        }
        
        return nil
    }
    
    func alart(message: String){
        let alart = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alart.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alart, animated: true)
    }
    
    
}
