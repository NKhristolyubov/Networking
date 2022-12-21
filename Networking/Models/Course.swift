//
//  Course.swift
//  Networking
//
//  Created by Nikolai Khristoliubov on 18.12.22.
//

import Foundation

struct Course: Codable {
    let name: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
}

struct WebsiteDescription: Decodable {
    let courses: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}
