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
    
    
    func configureCell(course: Course) {
        
        nameOfCourseLabel.text = course.name
        numberOfLessonsLabel.text = "Number of lessons: \(course.numberOfLessons ?? 0)"
        numberOfTestsLabel.text = "Number of tests: \(course.numberOfTests ?? 0)"
        
        NetworkManager.shared.fetchImage(url: course.imageUrl ?? "") { result in
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
