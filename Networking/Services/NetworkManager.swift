//
//  NetworkManager.swift
//  Networking
//
//  Created by Nikolai Khristoliubov on 21.12.22.
//

import Foundation
import Alamofire

enum Link: String {
    case imageURL = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    case exampleOne = "https://swiftbook.ru//wp-content/uploads/api/api_course"
    case exampleTwo = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
    case exampleThree = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
    case exampleFour = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
    case exampleFive = "https://swiftbook.ru//wp-content/uploads/api/api_courses_capital"
    case postRequest = "https://jsonplaceholder.typicode.com/posts"
    case courseImageURL = "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png"
}

enum NetworkError: Error {
    case invalidUrl
    case decodingError
    case noData
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetch<T: Decodable>(dataType: T.Type, url: String, convertFromSnakeCase: Bool = false, completion: @escaping(Result<T,NetworkError>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.decodingError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                if convertFromSnakeCase {
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                }
                let dataType = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataType))
                }
            } catch {
                completion(.failure(.noData))
            }
        }.resume()
    }
    
    func fetchImage(url: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            
            guard let url = URL(string: url) else {
                completion(.failure(.invalidUrl))
                return
            }
            
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func postRequest(data: [String: Any], url: String, completion: @escaping(Result<Any, NetworkError>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let courseData = try? JSONSerialization.data(withJSONObject: data)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = courseData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, let response = response else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No localized description")
                return
            }
            
            print(response)
            
            do {
                let course = try JSONSerialization.jsonObject(with: data)
                completion(.success(course))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func postRequest(data: CourseV3, url: String, completion: @escaping(Result<CourseV3, NetworkError>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let courseData = try? JSONEncoder().encode(data)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = courseData
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let course = try JSONDecoder().decode(CourseV3.self, from: data)
                completion(.success(course))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
        
    }
    
    func getRequestWithAlamofire(url: String, completion: @escaping(Result<[Course], NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let courses = Course.getCourses(from: value)
                    completion(.success(courses))
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(.decodingError))
                }
            }
    }
    
    func postRequestWithAlamofere(url: String, data: CourseV3, completion: @escaping(Result<Course, NetworkError>) -> Void) {
        AF.request(url, method: .post, parameters: data)
            .validate()
            .responseDecodable(of: CourseV3.self) { responseData in
                switch responseData.result {
                case .success(let courseV3):
                    let course = Course(
                        name: courseV3.name,
                        imageUrl: courseV3.imageUrl,
                        numberOfLessons: Int(courseV3.numberOfLessons) ?? 0,
                        numberOfTests: Int(courseV3.numberOfTests) ?? 0
                    )
                    completion(.success(course))
                case .failure(_):
                    completion(.failure(.decodingError))
                                
                }
            }
    }
}
