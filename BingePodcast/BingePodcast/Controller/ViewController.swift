//
//  ViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 04/06/2023.
//


import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
            try await testFecthDataOnFirebase()
        }
        print("@@@ here ")
    }
    
    func testFecthDataOnFirebase() async throws {
        print("@@@ here 2")
        do {
            let data = try await Firestore.firestore().collection("Podcast").document("Programe B").getDocument()
            guard let data = data.data() else {return}
            print("@@@ ici = \(data)")
            print("@@@ ici = \(data["name"])")
        } catch let e {
            print("@@@ error = \(e)")
        }
    }


}

