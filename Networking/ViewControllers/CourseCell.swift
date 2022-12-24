//
//  CourseCell.swift
//  Networking
//
//  Created by Nikolai Khristoliubov on 18.12.22.
//

import UIKit

class CourseCell: UITableViewCell {
    
    @IBOutlet var courseImageView: UIImageView!
    
    @IBOutlet var nameOfCourseLabel: UILabel!
    @IBOutlet var numberOfLessonsLabel: UILabel!
    @IBOutlet var numberOfTestsLabel: UILabel!
    
    private var imageURL: String? {
        didSet {
            fetchCourseImage(from: imageURL)
        }
    }
    
    func configureCell(course: Course) {
        nameOfCourseLabel.text = course.name
        numberOfLessonsLabel.text = "Number of lessons: \(course.numberOfLessons ?? 0)"
        numberOfTestsLabel.text = "Number of tests: \(course.numberOfTests ?? 0)"
        
        imageURL = course.imageUrl
    }
    
    func fetchCourseImage(from url: String?) {
        NetworkManager.shared.fetchImage(url: imageURL ?? "") { result in
            switch result {
            case .success(let imageData):
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    if url == self.imageURL {
                        self.courseImageView.image = image
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func configureCell(courseV2: CourseV2) {
        nameOfCourseLabel.text = courseV2.name
        numberOfLessonsLabel.text = "Number of lessons: \(courseV2.numberOfLessons ?? 0)"
        numberOfTestsLabel.text = "Number of tests: \(courseV2.numberOfTests ?? 0)"
        
        NetworkManager.shared.fetchImage(url: courseV2.imageUrl ?? "") { result in
            switch result {
            case .success(let imageData):
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.courseImageView.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
