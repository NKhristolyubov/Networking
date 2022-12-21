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
    case ourCourses = "Our Courses"
}

private let reuseIdentifier = "Cell"

class MainViewController: UICollectionViewController {
    
    private let userActions = UserAction.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
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
        case .ourCourses: performSegue(withIdentifier: "showCourses", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCourses" {
            guard let coursesVC = segue.destination as? CoursesTableViewController else { return }
            coursesVC.fetchCoutses()
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

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (view.window?.windowScene?.screen.bounds.width ?? 200) - 40, height: 100)
    }
}

extension MainViewController {
    
    private func exampleOneButtonPressed() {
        guard let url = URL(string: Link.exampleOne.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "no localized description!")
                return
            }
            do {
                let course = try JSONDecoder().decode(Course.self, from: data)
                print(course)
                self.showSuccesAlert()
            } catch {
                self.showFailedAlert()
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    private func exampleTwoButtonPressed() {
        guard let url = URL(string: Link.exampleTwo.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "no localized description!")
                return
            }
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                self.showSuccesAlert()
                print(courses)
            } catch {
                print(error.localizedDescription)
                self.showFailedAlert()
            }
        }.resume()
    }
    
    private func exampleThreeButtonPressed() {
        guard let url = URL(string: Link.exampleThree.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "no localized description!")
                return
            }
            do {
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print(websiteDescription)
                self.showSuccesAlert()
            } catch {
                print(error.localizedDescription)
                self.showFailedAlert()
            }
        }.resume()
    }
    
    private func exampleFourButtonPressed() {
        guard let url = URL(string: Link.exampleFour.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "no localized description!")
                return
            }
            do {
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print(websiteDescription)
                self.showSuccesAlert()
                
            } catch {
                print(error.localizedDescription)
                self.showFailedAlert()
            }
            
        }.resume()
    }
}
