//
//  ViewController.swift
//  NetworkCheck
//
//  Created by Ala'a Araishi on 1/6/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var CheckConnectionTest: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if (NetworkMonitor.shared.isConnected ){
            CheckConnectionTest.text = "\(NetworkMonitor.shared.connectionType) is connected"

        }else{
            CheckConnectionTest.text = "No Internet connection."
        }
    }

}
