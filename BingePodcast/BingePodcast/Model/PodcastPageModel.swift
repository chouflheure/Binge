
import Foundation

class PodcastPageModel {
    
    let firebaseService = FirebaseService()
    weak var podcastPageDelegate: PodcastPageDelegate?
    
    func fetchAllPodcast() {
        firebaseService.fetchAllPodcastFirebase { result in
            switch result {
            case .success(let data):
                guard let data = data else {return}
                self.podcastPageDelegate?.fetchPodcastList(result: data)
            case .failure(let error):
                print("@@@ error = \(error)")
            }
        }
    }
    
    func fetchEpisodePodcast(podcast: String) {
        
    }

}
