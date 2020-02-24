//
//  HomeModel.swift
//  Kaodim
//
//  Created by InsightzClub on 23/02/2020.
//  Copyright © 2020 Tharsshinee. All rights reserved.
//

import Foundation

// MARK: - Kaodim
struct Kaodim: Codable{
    let list : [List]
}

// MARK: - List
struct List: Codable {
    let name: String
    let serviceTypes: [ServiceType]
    
    enum CodingKeys: String, CodingKey {
        case  name
        case serviceTypes = "service_types"
    }
}

// MARK: - ThumbURL
struct ThumbURL: Codable {
    let lg, md, sm: String
}

// MARK: - ServiceType
struct ServiceType: Codable {
    let name: String
    let imageThumbURL: ThumbURL?
    
    enum CodingKeys: String, CodingKey {
        case  name
        case imageThumbURL = "image_thumb_url"
    }
}

