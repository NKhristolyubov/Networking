//
//  CoursesTableViewController.swift
//  Networking
//
//  Created by Nikolai Khristoliubov on 18.12.22.
//

import UIKit
import Alamofire

class CoursesTableViewController: UITableViewController {
    
    var courses:[Course] = []
    var coursesV2:[CourseV2] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 120
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        courses.isEmpty ? coursesV2.count : courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! CourseCell
        
        if !courses.isEmpty {
            let course = courses[indexPath.row]
            cell.configureCell(course: course)
        } else {
            let courseV2 = coursesV2[indexPath.row]
            cell.configureCell(courseV2: courseV2)
        }
        
        return cell
    }
    
}

// MARK: - Extensions
extension CoursesTableViewController {
    
    func fetchCourses() {
        NetworkManager.shared.fetch(dataType: [Course].self, url: Link.exampleTwo.rawValue, convertFromSnakeCase: true) { result in
            switch result {
            case .success(let courses):
                DispatchQueue.main.async {
                    self.courses = courses
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCoursesV2() {
        NetworkManager.shared.fetch(dataType: [CourseV2].self, url: Link.exampleFive.rawValue) { result in
            switch result {
            case .success(let coursesV2):
                DispatchQueue.main.async {
                    self.coursesV2 = coursesV2
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getAlamofireButtonPressed() {
        NetworkManager.shared.getRequestWithAlamofire(url: Link.exampleTwo.rawValue) { result in
            switch result {
            case .success(let courses):
                self.courses = courses
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func postAlamofireButtonPressed() {
        
        let course = CourseV3(name: "Networking",
                              imageUrl: Link.courseImageURL.rawValue,
                              numberOfLessons: "10",
                              numberOfTests: "5")
        
        NetworkManager.shared.postRequestWithAlamofere(url: Link.postRequest.rawValue, data: course) { result in
            switch result {
            case .success(let course):
                self.courses.append(course)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

