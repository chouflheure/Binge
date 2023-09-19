import Foundation

class HomePageModel {
    
    let firebaseService: FirebaseServiceProtocol
    weak var homePageDelegate: HomePageDelegate?
    
    init(firebaseService: FirebaseServiceProtocol) {
        self.firebaseService = firebaseService
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
}
