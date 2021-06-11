//
//  PhotoViewModel.swift
//  SwiftMVVM
//
//  Created by KasimOzdemir on 27.05.2021.
//

import Foundation
import Combine

class PhotoViewModel: BaseViewModel {
    @Published var photos: [Photo] = []
    @Published var photo: Photo? = nil

    private var photoService: PhotoService?

    init(photoService: PhotoService = PhotoService()) {
        self.photoService = photoService
    }
    
    func fetchPhoto(id : Int) {
        self.showDialog = true
        self.photoService?.requestFetchPhoto(with: id, completion:{ (photo, error) in
            self.showDialog = false
            if let error = error {
                self.error = error
                return
            }
            self.photo = photo
        })
    }
    
    func fetchPhotos() {
        self.showDialog = true
        self.photoService?.requestFetchPhotos(completion: { (photos, error) in
            self.showDialog = false
            if let error = error {
                self.error = error
                return
            }
            self.photos = photos ?? []
        })
    }

}
