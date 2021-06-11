//
//  BaseViewController.swift
//  SwiftMVVM
//
//  Created by KasimOzdemir on 27.05.2021.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    var viewModel: BaseViewModel {
        get {
            return self.viewModel
        }
        set(viewModel) {
            viewModel.$showDialog.sink{ value in
                let _ = value ? self.startActivityIndicator() : self.stopActivityIndicator()
            }.store(in: &baseCancellables)
            
            viewModel.$error.sink{ value in
                self.alertError(message: value?.localizedDescription, completion: nil)
            }.store(in: &baseCancellables)
        }
    }
    
    private var baseCancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initViewModel(viewModel : BaseViewModel) {
        self.viewModel = viewModel
    }
    
}
