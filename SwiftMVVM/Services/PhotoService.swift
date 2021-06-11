//
//  DataService.swift
//  SwiftMVVM
//
//  Created by KasimOzdemir on 27.05.2021.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class PhotoService : MainService {
            
    func requestFetchPhoto(with id: Int, completion: @escaping (Photo?, Error?) -> Void) {
        request(endPoint: "/\(id)",type: Photo.self) { (photo, error) in
            completion(photo, error)
        }
    }
    
    func requestFetchPhotos(completion: @escaping ([Photo]?, Error?) -> ()) {
        requestArray(endPoint: "",type: Photo.self) { (photos, error) in
            completion(photos, error)
        }
    }
    
}
