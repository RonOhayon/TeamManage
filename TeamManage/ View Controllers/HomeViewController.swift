//
//  HomeViewController.swift
//  TeamManage
//
//  Created by user216780 on 7/6/22.
//

import UIKit
import Firebase
import SwiftUI


class HomeViewController: UIViewController {
    
    @IBOutlet var addButtom: UIImageView!
    @IBOutlet var tasklist: UITableView!
    @IBOutlet var nameLabl: UILabel!
    var tasks: [Todo] = []

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        @ObservedObject var model = ViewModel()
        model.getData()
        tasks = model.tasks
        
        tasklist.delegate = self
        tasklist.dataSource = self
        
        let tapGestturerec = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageTapped ))
        addButtom.addGestureRecognizer(tapGestturerec)
        addButtom.isUserInteractionEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(notification:)), name: Notification.Name("todo"), object: nil)
    }
   @objc func didGetNotification(notification: Notification){
       let todo = notification.object as! Todo
       tasks.append(todo)
       tasklist.reloadData()

   }
    
    @objc func imageTapped(){
        
    let vc = storyboard?.instantiateViewController(withIdentifier: "newTaskView") as! NewTaskViewController
    vc.modalPresentationStyle = .fullScreen

    present(vc,animated: true)
    }

}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tasklist.dequeueReusableCell(withIdentifier: "customCell") as! CustomViewCell
        let task = tasks[indexPath.row]
        cell.taskLabel.text = task.name
        cell.dateIssue.text = "Date Issue: " + task.dateIssue
        cell.dateTodo.text = "Date Todo: " + task.dateTodo
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let task = tasks[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "taskView") as! TaskViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        NotificationCenter.default.post(name: Notification.Name("task"), object: task)
        
    }
}


