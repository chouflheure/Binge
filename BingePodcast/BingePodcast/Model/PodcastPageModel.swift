
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
                let test = PodcastEpisode(podcast: podcast, episode: data)
                self.podcastPageDelegate?.showPodcastAnEpisode(podcastEpisode: test)
            case .failure(let error):
                print("@@@ error = \(error)")
            }
            
        })
    }
    
    func fetchEpisodeMore(podcast: Podcast) {
        print("@@@ here")
        print("@@@ podcast = \(podcast)")
        self.firebaseService.loadMoreData(podcastName: podcast.title ?? "", onCompletion: { result in
            print("@@@ resul = \(result)")
            switch result {
            case .success(let data):
                guard let data = data else {return}
                let test = PodcastEpisode(podcast: Podcast(title: "Panier Piano", image: "", author: ""), episode: data)
                test.episode.enumerated().forEach{ e in
                    print("@@@ episode fetchEpisodePodcast = \(e.element.subtitle)")
                }
                self.podcastPageDelegate?.test(podcastEpisode: test)
            case .failure(let error):
                print("@@@ error = \(error)")
            }
        })
    }

}
