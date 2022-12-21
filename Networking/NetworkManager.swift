//
//  NetworkManager.swift
//  Networking
//
//  Created by Nikolai Khristoliubov on 21.12.22.
//

import Foundation

enum Link: String {
    case imageURL = "https://vsegda-pomnim.com/uploads/posts/2022-04/1649335120_6-vsegda-pomnim-com-p-bali-plyazh-foto-7.jpg"
    case exampleOne = "https://swiftbook.ru//wp-content/uploads/api/api_course"
    case exampleTwo = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
    case exampleThree = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
    case exampleFour = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
}

enum NetworkError: Error {
    case invalidUrl
    case decodingError
    case noData
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetch<T:Decodable>(dataType: T.Type, url: String, completion: @escaping(Result<T,NetworkError>) -> Void) {
        
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
                let dataType = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataType))
                }
            } catch {
                completion(.failure(.noData))
            }
        }.resume()
    }
    
    func fetchImage(url: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
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
