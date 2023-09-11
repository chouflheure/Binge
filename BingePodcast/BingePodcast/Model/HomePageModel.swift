import Foundation

class HomePageModel {
    
    let firebaseService = FirebaseService()
    weak var homePageDelegate: HomePageDelegate?
    
    func fetchAllAuthor() {
        firebaseService.fetchAllAuthorFirebase { result in
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
                self.homePageDelegate?.fetchPodcastListAndShowOnHomePage(result: data)
            case .failure(let error):
                print("@@@ error = \(error)")
            }
        }
    }
/*
    func testfetchDataOnPosdcastFirebase() {
        firebaseService.fetchDataOnPosdcastFirebase { result in
            print("@@@ ==============")

            result?.forEach{ podcast in
                print("@@@ data episode = \(podcast)")
            }
        }
    }
*/

    func test() {
        firebaseService.fetchRandomPodcast(onCompletion: { result in
            print("@@@ number = \(result)")
        })
    }

}
