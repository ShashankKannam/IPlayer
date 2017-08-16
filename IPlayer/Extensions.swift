//
//  Extensions.swift
//  IPlayer
//
//  Created by Shashank Kannam on 8/15/17.
//  Copyright © 2017 Shashank Kannam. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func activityIndicatorSetup(viewTo: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        activityIndicator.color = UIColor.white
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        viewTo.addSubview(activityIndicator)
        activityIndicator.center = viewTo.center
        activityIndicator.layer.cornerRadius = 20
        activityIndicator.layer.shadowOffset.height = 3
        activityIndicator.layer.shadowOffset.width = 2
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func alert(message: String, titleAlert: String) {
        let alertController = UIAlertController(title: titleAlert, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}
