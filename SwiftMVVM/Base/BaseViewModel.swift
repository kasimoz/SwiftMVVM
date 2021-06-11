//
//  BaseViewModel.swift
//  SwiftMVVM
//
//  Created by KasimOzdemir on 27.05.2021.
//

import Foundation
import Combine

class BaseViewModel: ObservableObject {
    @Published var showDialog: Bool = false
    @Published var error: Error? = nil
}
