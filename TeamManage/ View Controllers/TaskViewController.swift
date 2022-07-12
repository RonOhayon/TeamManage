//
//  TaskViewController.swift
//  TeamManage
//
//  Created by user216780 on 7/11/22.
//

import UIKit

class TaskViewController: UIViewController {

   
    @IBOutlet var backButtom: UIImageView!
    @IBOutlet var doneButtom: UIButton!
    @IBOutlet var taskDataLBL: UITextView!
    @IBOutlet var dateIssueLBL: UILabel!
    @IBOutlet var dateTodoLBL: UILabel!
    @IBOutlet var titleLBL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(notification:)), name: Notification.Name("task"), object: nil)
        //set back buttom
        let tapGestturerec = UITapGestureRecognizer(target: self, action: #selector(TaskViewController.imageTapped ))
        backButtom.addGestureRecognizer(tapGestturerec)
        backButtom.isUserInteractionEnabled = true
    }
    @objc func imageTapped(){
        dismiss(animated: true,completion: nil)
    }
    
    @objc func didGetNotification(notification: Notification){
        let todo = notification.object as! Todo
        taskDataLBL.text = todo.note
        dateIssueLBL.text = todo.dateIssue
        dateTodoLBL.text = todo.dateTodo
        titleLBL.text = todo.name
    }
   
    
}
