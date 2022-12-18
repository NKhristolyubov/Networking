//
//  Course.swift
//  Networking
//
//  Created by Nikolai Khristoliubov on 18.12.22.
//

import Foundation

struct Course: Decodable {
    let name: String?
    let imageUrl: String?
    let number_of_lessons: Int?
    let number_of_tests: Int?
}

struct WebsiteDescription: Decodable {
    let courses: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}
