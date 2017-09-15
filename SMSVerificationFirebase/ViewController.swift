//
//  ViewController.swift
//  SMSVerificationFirebase
//
//  Created by vishalsonawane on 15/09/17.
//  Copyright © 2017 vishalsonawane. All rights reserved.
//

import UIKit
import FirebaseAuth
//import FirebaseAuthUI
//import FirebasePhoneAuthUI


class ViewController: UIViewController{//,FUIAuthDelegate {
    @IBOutlet weak var mobileNumberTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        
//        
//        let authVC = FUIAuth.defaultAuthUI()
//        authVC?.delegate = self
//        
//        let phone = FUIPhoneAuth(authUI: authVC!)
//        authVC?.providers = [phone]
//        
//        phone.signIn(withPresenting: self)
        
        
    }
    
//    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
//        if error == nil {
//            print("Sucess...")
//            
//        }else{
//            print(error?.localizedDescription ?? "ERROR")
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var shouldGoAhead = true
        let phoneNumber = mobileNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if phoneNumber.isEmpty || phoneNumber == "" {
            print("Please enter phone number")
            Utilities.showError(errorMessage: "Please enter phone number")
             shouldGoAhead = false
        }else if !phoneNumber.isPhoneNumber{
            print("Please enter valid phone number")
            Utilities.showError(errorMessage: "Please enter valid phone number")
            shouldGoAhead = false
        }else{
            //Send parameters to verify phone number.If number is valid,verification code will be sent to that number
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber) { (verificationID, error) in
                if let error = error {
                    print(error.localizedDescription)
                    Utilities.showErrorAlert(alertMessage: error.localizedDescription)
                    shouldGoAhead = false
                }else{
                    Utilities.showSucess(successMessage: "Verification code sent successfully")
                    //Save verification id for future reference
                    shouldGoAhead = true
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                    UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
                }
                
            }
        }
        
        
        return shouldGoAhead

    }
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
    }
    
}

extension String {
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.characters.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.characters.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
