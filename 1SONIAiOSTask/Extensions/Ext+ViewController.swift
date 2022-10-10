//
//  Ext+ViewController.swift
//  1SONIAiOSTask
//
//  Created by Mekhriddin Jumaev on 10/10/22.
//

import UIKit

fileprivate var containerView: LoadingView!

extension UIViewController {
    
    func showLoadingView(){
        containerView = LoadingView()
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.size.equalTo(view)
        }
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
    }
    
    func dissmissLoadingView(){
        DispatchQueue.main.async {
            if let container = containerView {
                container.removeFromSuperview()
            }
            containerView = nil
        }
    }
    
    func open(url: String) {
        if let newUrl = URL(string: url.trimmed) {
            if UIApplication.shared.canOpenURL(newUrl) {
                UIApplication.shared.open(newUrl, completionHandler: nil)
            }
        }
    }
    
}

