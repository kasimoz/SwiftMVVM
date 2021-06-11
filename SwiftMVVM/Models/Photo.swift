//
//  Photo.swift
//  SwiftMVVM
//
//  Created by KasimOzdemir on 27.05.2021.
//

import Foundation
import ObjectMapper

struct Photo : Mappable {
    var albumId : Int?
    var id : Int?
    var title : String?
    var url : String?
    var thumbnailUrl : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        albumId <- map["albumId"]
        id <- map["id"]
        title <- map["title"]
        url <- map["url"]
        thumbnailUrl <- map["thumbnailUrl"]
    }

}

