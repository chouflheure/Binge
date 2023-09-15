import Foundation

class HomePageModel {
    
    let firebaseService = FirebaseService()
    weak var homePageDelegate: HomePageDelegate?
    
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
