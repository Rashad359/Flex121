//
//  FirebaseTestVC.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/28/25.
//

import UIKit
import FirebaseFirestore

final class FirebaseTestVC: UIViewController, UITextFieldDelegate {
    
    private let database = Firestore.firestore()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.textColor = .black
        
        return label
    }()
    
    private lazy var field: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter text..."
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        field.delegate = self
        field.textColor = .black
        
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(field)
        view.backgroundColor = .white
        
        let docRef = database.document("testbuild/example")
        
        docRef.addSnapshotListener { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            
            guard let text = data["text"] as? String else { return }
            
            print(data)
            
            DispatchQueue.main.async {
                self?.label.text = text
            }
        }
//        docRef.getDocument { [weak self] snapshot, error in
//            guard let data = snapshot?.data(), error == nil else { return }
//            
//            guard let text = data["text"] as? String else { return }
//            
//            DispatchQueue.main.async {
//                self?.label.text = text
//            }
//        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        field.frame = CGRect(
            x: 10,
            y: view.safeAreaInsets.top + 10,
            width: view.frame.size.width - 20,
            height: 50
        )
        
        label.frame = CGRect(
            x: 10,
            y: view.safeAreaInsets.top + 10 + 60,
            width: view.frame.size.width - 20,
            height: 100
        )
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty {
            saveData(text: text)
        }
        return true
    }
    
    private func saveData(text: String) {
        let docRef = database.document("testbuild/example")
        docRef.setData(["text": text])
        
//        database.collection("users").addDocument(data: [
//            "name": text,
//            "age": 25
//        ]) { error in
//            if let error = error {
//                print("Something went wrong \(error.localizedDescription)")
//            } else {
//                print("Everything's in place")
//            }
//        }
    }
    
    private func getData() {
        database.collection("users").getDocuments { querySnapshot, error in
            if let error = error {
                print("Something is wrong \(error.localizedDescription)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    private func listenForUsers() {
        database.collection("users").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            for doc in documents {
                print("\(doc.documentID) => \(doc.data())")
            }
        }
    }
}
