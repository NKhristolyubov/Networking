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
    
    init(courseData: [String: Any]) {
        name = courseData["name"] as? String
        imageUrl = courseData["imageUrl"] as? String
        numberOfLessons = courseData["number_of_lessons"] as? Int
        numberOfTests = courseData["number_of_tests"] as? Int
    }
    
    static func getCourses(from value: Any) -> [Course] {
        guard let coursesData = value as? [[String: Any]] else { return [] }
        var courses: [Course] = []
        for courseData in coursesData {
            let course = Course(courseData: courseData)
            courses.append(course)
        }
        return courses
    }
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
struct CourseV3: Codable {
    let name: String
    let imageUrl: String
    let numberOfLessons: String
    let numberOfTests: String
}

struct WebsiteDescription: Codable {
    let courses: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}
