//
//  DogFeedViewController.swift
//  IDdog
//
//  Created by lugia on 13/09/18.
//  Copyright © 2018 MicFaifer. All rights reserved.
//

import UIKit

class DogFeedViewController: UIViewController {
    var user: User?

    let dogFeedService = DogFeedService()

    // MARK: - Outlets

    @IBOutlet weak var dogFeedCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = user {
            dogFeedService.fetchDogs(userKey: user.token) { (result) in
                DispatchQueue.main.async {
                    print(result)
                }
            }
        }
    }
}
