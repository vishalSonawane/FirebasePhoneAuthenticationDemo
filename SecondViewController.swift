//
//  SecondViewController.swift
//  SMSVerificationFirebase
//
//  Created by vishalsonawane on 15/09/17.
//  Copyright © 2017 vishalsonawane. All rights reserved.
//

import UIKit
import FirebaseAuth
class SecondViewController: UIViewController {

    @IBOutlet weak var verificationCodetextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func didTapResendVerificationCode(_ sender: Any) {
        
        //Send parameters to verify phone number.If number is valid,verification code will be sent to that number
        let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber")
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber!) { (verificationID, error) in
            if let error = error {
                print(error.localizedDescription)
                Utilities.showErrorAlert(alertMessage: error.localizedDescription)
                return
            }else{
                print("Verification code sent successfully again")
                Utilities.showSucess(successMessage: "Verification code sent successfully")
                //Save verification id for future reference
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            }
            
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var shouldGoAhead = true
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        let verificationCode = verificationCodetextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if verificationCode.isEmpty || verificationCode == "" {
            print("please enter verification code")
            Utilities.showError(errorMessage: "Please enter verification code")
            shouldGoAhead = false
        }else{
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: verificationID!,
                verificationCode: verificationCode)
            // Sign in using the verificationID and the code sent to the user
            
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    Utilities.showError(errorMessage: error.localizedDescription)
                    shouldGoAhead = false
                }else{
                    // User is signed in
                    print("User signed in successfully")
                    
                }
                
            }
        }
        
        
        return shouldGoAhead
    }
    
}
