//
//  ViewModel.swift
//  TeamManage
//
//  Created by user216780 on 7/12/22.
//

import Foundation
import Firebase
class ViewModel: ObservableObject {
    @Published var tasks: [Todo] = []
    
    func getData(){
        //get reference to the database
        let db = Firestore.firestore()
        
        //read the document
        db.collection("tasks").getDocuments { snapshot, error in
            // check for error
            if error == nil{
                //no error
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        // get all the documents and create a Todos
                        self.tasks = snapshot.documents.map { d in
                            
                            return Todo(id: d.documentID,
                                        name: d["name"]as? String ?? "",
                                        dateIssue: d["dateIssue"]as?  String ?? "",
                                        dateTodo: d["dateTodo"]as? String ?? "",
                                        note: d["note"]as? String ?? "")
                        }
                    }
                    
                   
        
                }
            }else{
                
            }
        }
    }
}
