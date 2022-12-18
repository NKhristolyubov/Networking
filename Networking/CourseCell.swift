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
    @IBOutlet var nemberOfTestsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
