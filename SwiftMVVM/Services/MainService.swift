//
//  GenericService.swift
//  SwiftMVVM
//
//  Created by KasimOzdemir on 28.05.2021.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class MainService {
        
    private var baseUrl = "https://jsonplaceholder.typicode.com/photos"
    
    func request<T: Mappable>(endPoint : String = "",
                              method: HTTPMethod = .get,
                              parameters: Parameters? = nil,
                              encoding: ParameterEncoding = URLEncoding.default,
                              headers: HTTPHeaders? = nil,
                              type: T.Type,
                              completion: @escaping (T?, Error?) -> Void) {
   
        Alamofire.request(baseUrl.appending(endPoint.isEmpty ? "" : endPoint), method: method, parameters: parameters, encoding: encoding, headers: headers).validate(statusCode: 200..<401).responseObject { (response: DataResponse<T>) in

            if let error = response.error {
                completion(nil, error)
                return
            }
            if let value = response.result.value {
                completion(value, nil)
                return
            }
        }
    }
    
    func requestArray<T: Mappable>(endPoint : String = "",
                              method: HTTPMethod = .get,
                              parameters: Parameters? = nil,
                              encoding: ParameterEncoding = URLEncoding.default,
                              headers: HTTPHeaders? = nil,
                              type: T.Type,
                              completion: @escaping ([T]?, Error?) -> Void) {
   
        Alamofire.request(baseUrl.appending(endPoint.isEmpty ? "" : endPoint), method: method, parameters: parameters, encoding: encoding, headers: headers).validate(statusCode: 200..<401).responseArray { (response: DataResponse<[T]>) in

            if let error = response.error {
                completion(nil, error)
                return
            }
            if let value = response.result.value {
                completion(value, nil)
                return
            }
        }
    }
    
}


