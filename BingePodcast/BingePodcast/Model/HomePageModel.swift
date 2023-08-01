//
//  HomePageModel.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 31/07/2023.
//

import Foundation

class HomePageModel {
    
    let firebaseService = FirebaseService()
    weak var homePageDelegate: HomePageDelegate?
    
    func fetchAllAuthor() {
        firebaseService.fetchAllAuthorFirebase { result in
            print("@@@ ==============")
            result?.forEach{ author in
                print("@@@ data author = \(author)")
            }
        }
    }
    
    func fetchAllPodcast() {
        firebaseService.fetchAllPodcastFirebase { result in
            switch result {
            case .success(let data):
                guard let data = data else {return}
                print("@@@ data = \(data)")
                self.homePageDelegate?.test(result: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func fetchDataOnPosdcastFirebase() {
        firebaseService.fetchDataOnPosdcastFirebase { result in
            print("@@@ ==============")

            result?.forEach{ podcast in
                print("@@@ data episode = \(podcast)")
            }
        }
    }

}
