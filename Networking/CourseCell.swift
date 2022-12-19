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
        numberOfLessonsLabel.text = "Number of lessons: \(course.number_of_lessons ?? 0)"
        numberOfTestsLabel.text = "Number of tests: \(course.number_of_tests ?? 0)"
        
        DispatchQueue.global().async {
            guard let url = URL(string: course.imageUrl ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.courseImageView.image = UIImage(data: imageData)
            }
        }
    }
}
