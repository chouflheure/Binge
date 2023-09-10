
import Foundation

class PodcastPageModel {
    
    let firebaseService = FirebaseService()
    weak var podcastPageDelegate: PodcastPageDelegate?
    
    // This method retrieves all the information on the list of podcasts
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
    
    // This method fetches podcasts retrieved and displays them in the pagecontroller
    func fetchEpisodePodcast(podcast: Podcast) {
        firebaseService.fetchEpisodeOnPosdcastFirebase(podcastName: podcast.title ?? "", onCompletion: { result in
            switch result {
            case .success(let data):
                guard let data = data else {return}
                let test = PodcastEpisode(podcast: podcast, episode: data)
                self.podcastPageDelegate?.showPodcastAndEpisode(podcastEpisode: test)
            case .failure(let error):
                print("@@@ error = \(error)")
            }
            
        })
    }
    
    // This method retrieves the next 5 episodes
    func fetchEpisodeMore(podcast: Podcast) {
        self.firebaseService.loadMoreData(podcastName: podcast.title ?? "", onCompletion: { result in
            print("@@@ resul = \(result)")
            switch result {
            case .success(let data):
                guard let data = data else {return}
                let episode = PodcastEpisode(podcast: Podcast(title: podcast.title, image: "", author: ""), episode: data)
                episode.episode.enumerated().forEach{ e in
                }
                self.podcastPageDelegate?.loadMoreEpisode(podcastEpisode: episode)
            case .failure(let error):
                print("@@@ error = \(error)")
            }
        })
    }

}
