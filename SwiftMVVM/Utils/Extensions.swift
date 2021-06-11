//
//  Extensions.swift
//  SwiftMVVM
//
//  Created by KasimOzdemir on 27.05.2021.
//

import Foundation
import UIKit

extension UIViewController {
    func startActivityIndicator(style: UIActivityIndicatorView.Style = UIActivityIndicatorView.Style.medium, location: CGPoint? = nil) {
        stopActivityIndicator()
        DispatchQueue.main.async {
            let share = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            
            let activityIndicator = UIActivityIndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: (share?.bounds.width)!, height: (share?.bounds.height)!))
            activityIndicator.tag = 777
            activityIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            activityIndicator.style = .large
            activityIndicator.color = .orange
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            
            share?.addSubview(activityIndicator)
            
        }
        
    }
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            if let activityIndicator = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.subviews.filter(
                { $0.tag == 777}).first as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
    func alertError(message: String? = nil, completion: ((_ result: Bool)->())? = nil){
        guard let message = message else {
            return
        }
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            completion?(true)
        }))

        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX , y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = .init(rawValue: 0)
        }
        self.present(alert, animated: true, completion: nil)
    }
}

