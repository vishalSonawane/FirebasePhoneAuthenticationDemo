//
//  Utilities.swift
//  SMSVerificationFirebase
//
//  Created by vishalsonawane on 15/09/17.
//  Copyright © 2017 vishalsonawane. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages
class Utilities {
    static func showError(errorMessage:String){
        let status2 = MessageView.viewFromNib(layout: .StatusLine)
        status2.backgroundView.backgroundColor = UIColor.red
        status2.bodyLabel?.textColor = UIColor.white
        status2.configureContent(body: errorMessage)
        var status2Config = SwiftMessages.defaultConfig
        status2Config.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        status2Config.preferredStatusBarStyle = .lightContent
        SwiftMessages.show(config: status2Config, view: status2)
        
    }
    static func showSucess(successMessage:String){
        let status2 = MessageView.viewFromNib(layout: .StatusLine)
        status2.backgroundView.backgroundColor = UIColor.green
        status2.bodyLabel?.textColor = UIColor.white
        status2.configureContent(body: successMessage)
        var status2Config = SwiftMessages.defaultConfig
        status2Config.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        status2Config.preferredStatusBarStyle = .lightContent
        SwiftMessages.show(config: status2Config, view: status2)
    }
    
    static func showErrorAlert(alertMessage:String){
        let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        
        if let topController = UIApplication.topViewController() {
            topController.present(alert, animated: true, completion: nil)
        }
    }
    
}
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
