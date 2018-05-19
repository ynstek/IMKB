//
//  AlertFunctions.swift
//  Orca POS Mobile
//
//  Created by Yunus TEK on 21.03.2017.
//  Copyright © 2017 Orca Businesss Solutions. All rights reserved.
//

import UIKit
import Foundation

private let _sharedAlertFunctions = AlertFunctions()


class AlertFunctions : NSObject {
    
    // MARK: - SHARED INSTANCE
    class var messageType : AlertFunctions {
        return _sharedAlertFunctions
    }
    
    func showYesNoAlert(_ titleMessage: String, bodyMessage: String, _ yes: @escaping () -> Void, no: @escaping () -> Void){
        
        let alertController = UIAlertController(title: titleMessage, message: bodyMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Evet", style: .default , handler: { (action: UIAlertAction!) in
            yes()
        }))
        
        alertController.addAction(UIAlertAction(title: "Hayır", style: .cancel , handler: {(action: UIAlertAction!) in
            no()
        }))
        
        UIViewController().getTopController().present(alertController, animated:true, completion:nil)
    }
    
    func showOKAlert(_ titleMessage: String, bodyMessage: String){
        
        let alertController = UIAlertController(title: titleMessage, message: bodyMessage, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "TAMAM", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        UIViewController().getTopController().present(alertController, animated:true, completion:nil)
    }
}

