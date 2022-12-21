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

struct CourseV2: Codable {
    let name: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case imageUrl = "ImageUrl"
        case numberOfLessons = "Number_of_lessons"
        case numberOfTests = "Number_of_tests"
    }
}

struct WebsiteDescription: Codable {
    let courses: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}
