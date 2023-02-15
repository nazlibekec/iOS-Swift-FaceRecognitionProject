//
//  ViewController.swift
//  FaceRecognitionProject
//
//  Created by Nazlı Bekeç on 16.02.2023.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        let authContext = LAContext()
        var error : NSError?
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") { success, error in
                
                if success == true {
                    //successful auth
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        self.textLabel.text = "Error!"
                    }
                }
            }
        }
    }
}

//infodan izin iste.
// UIViewController.performSegue(withIdentifier:sender:) must be used from main thread only.  Bu hatayı aldık. Çözümü: ana thread de çalıştırmamız gerek. DispatchQueue ile.
