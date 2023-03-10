//
//  MainViewController.swift
//  Networking
//
//  Created by Nikolai Khristoliubov on 17.12.22.
//

import UIKit

enum UserAction: String, CaseIterable {
    case downloadImage = "Download Image"
    case exampleOne = "Example One"
    case exampleTwo = "Example Two"
    case exampleThree = "Example Three"
    case exampleFour = "Example Four"
    case exampleFive = "Example Five"
    case ourCourses = "Our Courses"
    case postRequest = "Post Request"
    case postRequestModel = "Post Request with Model"
    case getAlamofire = "get Alamofire"
    case postAlamofire = "post Alamofire"
}

class MainViewController: UICollectionViewController {
    
    private let reuseIdentifier = "Cell"
    private let userActions = UserAction.allCases
    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier != "showImage" {
             guard let coursesVC = segue.destination as? CoursesTableViewController else { return }
             switch segue.identifier {
             case "showCourses": coursesVC.fetchCourses()
             case "showCoursesV2": coursesVC.fetchCoursesV2()
             case "getAlamofire": coursesVC.getAlamofireButtonPressed()
             case "postAlamofire": coursesVC.postAlamofireButtonPressed()
             default: break
             }
         }
     }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UserActionCell
        let userAction = userActions[indexPath.item]
        cell.userActionLabel.text = userAction.rawValue
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        switch userAction {
            
        case .downloadImage: performSegue(withIdentifier: "showImage", sender: nil)
        case .exampleOne: exampleOneButtonPressed()
        case .exampleTwo: exampleTwoButtonPressed()
        case .exampleThree: exampleThreeButtonPressed()
        case .exampleFour: exampleFourButtonPressed()
        case .exampleFive: performSegue(withIdentifier: "showCoursesV2", sender: nil)
        case .ourCourses: performSegue(withIdentifier: "showCourses", sender: nil)
        case .postRequest: postRequestButtonPressed()
        case .postRequestModel: postRequestWithModel()
        case .getAlamofire: performSegue(withIdentifier: "getAlamofire", sender: nil)
        case .postAlamofire: performSegue(withIdentifier: "postAlamofire", sender: nil)
        }
    }
    
    private func showSuccesAlert() {
        DispatchQueue.main.async {
            
            let alert = UIAlertController(
                title: "Succes",
                message: "You can see the results in the debug area",
                preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "cancel", style: .cancel)
            
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func showFailedAlert() {
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: "Failed!", message: "You can see the fiileds in the debug area", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "cancel", style: .cancel)
            
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}

// MARK: - Extensions

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (view.window?.windowScene?.screen.bounds.width ?? 200) - 40, height: 100)
    }
}

extension MainViewController {
    
    private func exampleOneButtonPressed() {
        NetworkManager.shared.fetch(dataType: Course.self, url: Link.exampleOne.rawValue) { result in
            switch result {
            case .success(let course):
                self.showSuccesAlert()
                print(course)
            case .failure(let error):
                self.showFailedAlert()
                print(error.localizedDescription)
            }
        }
    }
    
    private func exampleTwoButtonPressed() {
        NetworkManager.shared.fetch(dataType: [Course].self, url: Link.exampleTwo.rawValue) { result in
            switch result {
            case .success(let courses):
                self.showSuccesAlert()
                print(courses)
            case .failure(let error):
                self.showFailedAlert()
                print(error.localizedDescription)
            }
        }
    }
    
    private func exampleThreeButtonPressed() {
        NetworkManager.shared.fetch(dataType: WebsiteDescription.self, url: Link.exampleThree.rawValue) { result in
            switch result {
            case .success(let websiteDescription):
                self.showSuccesAlert()
                print(websiteDescription)
            case .failure(let error):
                self.showFailedAlert()
                print(error.localizedDescription)
            }
        }
    }
    
    private func exampleFourButtonPressed() {
        NetworkManager.shared.fetch(dataType: WebsiteDescription.self, url: Link.exampleFour.rawValue) { result in
            switch result {
            case .success(let websiteDescription):
                self.showSuccesAlert()
                print(websiteDescription)
            case .failure(let error):
                self.showFailedAlert()
                print(error.localizedDescription)
            }
        }
    }
    
    private func postRequestButtonPressed() {
        
        let post = [
            "name" : "Networking",
            "imageUrl" : "imageUrl",
            "numberOfLessons" : "8",
            "numberOfTests" : "20"
        ]
        NetworkManager.shared.postRequest(data: post, url: Link.postRequest.rawValue) { result in
            switch result {
            case .success(let course):
                print(course)
                self.showSuccesAlert()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func postRequestWithModel() {
        
        let courseV3 = CourseV3(name: "Some course",
                                imageUrl: Link.courseImageURL.rawValue,
                                numberOfLessons: "34",
                                numberOfTests: "12")
        
        NetworkManager.shared.postRequest(data: courseV3, url: Link.postRequest.rawValue) { result in
            switch result {
            case .success(let course):
                print(course)
                self.showSuccesAlert()
            case .failure(let error):
                print(error.localizedDescription)
                self.showFailedAlert()
            }
        }
    }
}
