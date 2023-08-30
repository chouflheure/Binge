
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
    
    func fetchEpisodePodcast(podcast: Podcast) {
        firebaseService.fetchEpisodeOnPosdcastFirebase(podcastName: podcast.title ?? "", onCompletion: { result in
            switch result {
            case .success(let data):
                guard let data = data else {return}
                print("@@@ episode = \(data)")
                // self.podcastPageDelegate?.fetchPodcastList(result: data)
                let test = PodcastEpisode(podcast: podcast, episode: data)
                self.podcastPageDelegate?.showPodcastAnEpisode(podcastEpisode: test)
                print("@@@ test Data = \(test)")
            case .failure(let error):
                print("@@@ error = \(error)")
            }
            
        })
    }

}
