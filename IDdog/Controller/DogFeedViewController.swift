//
//  DogFeedViewController.swift
//  IDdog
//
//  Created by lugia on 13/09/18.
//  Copyright © 2018 MicFaifer. All rights reserved.
//

import UIKit
import Kingfisher

private let dogCellIdentifier = "dogCell"

class DogFeedViewController: UIViewController {
    var user: User?

    var dogsData: [DogCategory:[String]] = [:]

    let dogFeedService = DogFeedService()

    //default category is husky
    var selectedCategory = DogCategory.husky

    // MARK: - Outlets

    @IBOutlet weak var dogFeedCollectionView: UICollectionView!

    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.selectedCategory = .husky
        case 1:
            self.selectedCategory  = .hound
        case 2:
            self.selectedCategory  = .pug
        case 3:
            self.selectedCategory  = .labrador
        default: break
        }

        loadDogs(dogCategory: selectedCategory)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dogFeedCollectionView.delegate = self
        self.dogFeedCollectionView.dataSource = self

        loadDogs(dogCategory: selectedCategory)
    }

    func loadDogs (dogCategory: DogCategory) {
        if let user = user {
            dogFeedService.fetchDogs(dogCategory: dogCategory, userKey: user.token) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self.dogsData[data.category] = data.list
                        self.dogFeedCollectionView.reloadData()
                    case .failure(let error):
                        self.alert(message: error.localizedDescription)
                    }
                }
            }
        }
    }
}

extension DogFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dogs = dogsData[selectedCategory] {
            return dogs.count
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dogs = dogsData[selectedCategory] else {return UICollectionViewCell()}

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dogCellIdentifier, for: indexPath) as! DogCollectionViewCell
        let dogImage = dogs[indexPath.row]
        cell.dogImageView.kf.setImage(with: URL(string: dogImage))
        return cell
    }
}
