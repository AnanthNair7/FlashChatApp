//
//  ChatVIewController.swift
//  FlashChat
//
//  Created by Ananth Nair on 28/08/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore

class ChatViewController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    let db = Firestore.firestore()
    
    
    
    var messages : [Message] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = "⚡️FlashChat"
        navigationItem.hidesBackButton = true
        
        
        tableView.register(UINib(nibName: K.cellNibName , bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()
    }
    func loadMessages(){
       
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            if let e = error {
                print("Error in retrieving data from fire Store \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        print(data)
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            print(newMessage)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath =  IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        if let messageBody = messageTextField.text ,let messageSender = Auth.auth().currentUser?.email {
            
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField:messageSender, K.FStore.bodyField :messageBody, K.FStore.dateField:Date().timeIntervalSince1970]) { error in
                if let e = error {
                    print("There is an error saving data in fire store \(e)")
                } else {
                    print("Successfully data saved ")
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                    
                }
                
            }
            
        }
    }
    @IBAction func logout(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}


extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath ) as! MessageCell
        cell.lable.text = message.body
        
        
        // This is message from current user
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.youImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named:K.BrandColors.lightPurple)
            cell.lable.textColor = UIColor(named: K.BrandColors.purple)
            
        }
            
        // This is message from another user
        else {
            cell.youImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.lable.textColor = UIColor(named: K.BrandColors.blue)
            
        }
        
        return cell
    }
    
    
}
