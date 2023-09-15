import Foundation
import Firebase

protocol FirebaseServiceProtocol {
    func fetchAllPodcastFirebase(onCompletion: @escaping (Result<[Podcast]?,Error>) -> Void)
    func fetchOneEpisodeFirebase(podcast: String, episodeNumber: Int, onCompletion: @escaping (Episode?) -> Void)
    func fetchEpisodeOnPosdcastFirebase(podcastName: String, onCompletion: @escaping (Result<[Episode]?,Error>) -> Void)
    func loadMoreData(podcastName: String, onCompletion: @escaping (Result<[Episode]?,Error>) -> Void)
    func fetchAllAuthorFirebase(onCompletion: @escaping ([Author]?) -> Void)
    func fetchRandomPodcast(onCompletion: @escaping (Episode?) -> Void)
}

public protocol FirebaseCommande {
    func getDocuments(collectionName: String, completion: @escaping (QuerySnapshot?, Error?) -> Void)
    func getDocumentsWithLimit(podcastName: String, completion: @escaping (QuerySnapshot?, Error?) -> Void)
    func getDocumentsWithLimitAndStart(podcastName: String, completion: @escaping (QuerySnapshot?, Error?) -> Void)
}

class FirebaseManager: FirebaseCommande {
    func getDocumentsWithLimitAndStart(podcastName: String, completion: @escaping (QuerySnapshot?, Error?) -> Void) {}
    
    
    func getDocumentsWithLimit(podcastName: String, completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        Firestore.firestore().collection(podcastName).limit(to: 5).getDocuments { (querySnapshot, err) in
            completion(querySnapshot, err)
        }
    }
    
    func getDocuments(collectionName: String, completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        Firestore.firestore().collection(collectionName).getDocuments() { (querySnapshot, err) in
            completion(querySnapshot, err)
        }
    }

}

public class FirebaseService {
    
    var arrayLastDocument = [String: DocumentSnapshot]()
    private var podcastLimit: Int = 5
    var lastDocument: DocumentSnapshot? = nil
    private var isLoading: Bool = false
    var firebaseManager: FirebaseCommande
    
    init(firebaseManager: FirebaseCommande = FirebaseManager()) {
        self.firebaseManager = firebaseManager
    }

    func fetchAllPodcastFirebase(onCompletion: @escaping (Result<[Podcast]?,Error>) -> Void) {
        firebaseManager.getDocuments(collectionName: "Podcast", completion: { (querySnapshot, err) in
            var podcast = [Podcast]()
            guard let querySnapshot = querySnapshot else {return}
            if let err = err {
                print("@@@ Error getting: \(err)")
                onCompletion(.failure(err))
            } else {
                for document in querySnapshot.documents {
                    podcast.append(Podcast(title: document.data()["title"] as? String,
                                           image: document.data()["image"] as? String,
                                           author: document.data()["author"] as? String)
                    )
                }
                onCompletion(.success(podcast))
            }
        })
    }
    
    func fetchOneEpisodeFirebase(podcast: String, episodeNumber: Int, onCompletion: @escaping (Episode?) -> Void) {
        firebaseManager.getDocuments(collectionName: podcast, completion: { (querySnapshot, err) in
            var episode: Episode
            if let err = err {
                print("@@@ Error getting: \(err)")
                onCompletion(nil)
            } else {
                if let document = querySnapshot?.documents[episodeNumber] {
                    episode = Episode(title: document.data()["title"] as? String,
                                      subtitle: document.data()["subtitle"] as? String,
                                      description: document.data()["description"] as? String,
                                      totalTime: document.data()["totalTime"] as? String,
                                      imageUrl: document.data()["imageUrl"] as? String,
                                      playerUrl: document.data()["playerUrl"] as? String,
                                      podcastTitle: podcast
                    )
                    onCompletion(episode)
                }
            }
        })
    }
    
    func fetchEpisodeOnPosdcastFirebase(podcastName: String, onCompletion: @escaping (Result<[Episode]?,Error>) -> Void) {

        firebaseManager.getDocumentsWithLimit(podcastName: podcastName, completion: { (querySnapshot, err) in
            var episode = [Episode]()
            if let err = err {
                print("@@@ Error getting: \(err)")
                onCompletion(.failure(err))
            } else {
                guard let documents = querySnapshot?.documents else {return}
                for document in documents {
                    episode.append(Episode(title: document.data()["title"] as? String,
                                           subtitle: document.data()["subtitle"] as? String,
                                           description: document.data()["description"] as? String,
                                           totalTime: document.data()["totalTime"] as? String,
                                           imageUrl: document.data()["imageUrl"] as? String,
                                           playerUrl: document.data()["playerUrl"] as? String,
                                           podcastTitle: podcastName)
                    )
                }
                self.arrayLastDocument[podcastName] = documents.last
                self.lastDocument = documents.last
                onCompletion(.success(episode))
            }
        })
    }
    
    func loadMoreData(podcastName: String,
                      onCompletion: @escaping (Result<[Episode]?,Error>) -> Void) {

        guard let lastDocument = self.arrayLastDocument[podcastName], !isLoading else {return}
        isLoading = true

        let query = Firestore.firestore().collection(podcastName)
                    .start(afterDocument: lastDocument)
                    .limit(to: podcastLimit)

        query.getDocuments { (querySnapshot, error) in
            self.isLoading = false
            if let error = error {
                print("@@@ Erreur lors du chargement des données suivantes : \(error.localizedDescription)")
                onCompletion(.failure(error))
            } else {
                var episode = [Episode]()
                if let documents = querySnapshot?.documents {
                    self.arrayLastDocument[podcastName] = documents.last
                    for document in documents {
                        episode.append(Episode(title: document.data()["title"] as? String,
                                                subtitle: document.data()["subtitle"] as? String,
                                                description: document.data()["description"] as? String,
                                                totalTime: document.data()["totalTime"] as? String,
                                                imageUrl: document.data()["imageUrl"] as? String,
                                                playerUrl: document.data()["playerUrl"] as? String,
                                                podcastTitle: podcastName )
                        )
                    }
                }
                onCompletion(.success(episode))
            }
        }
    }

    func fetchRandomPodcast(onCompletion: @escaping (Episode?) -> Void) {
        firebaseManager.getDocuments(collectionName: "Podcast", completion: { (querySnapshot, err) in
            if let err = err {
                print("@@@ Error getting: \(err)")
                onCompletion(nil)
            } else {
                guard let firstQuerySnapShot = querySnapshot?.documents[0] else {return}
                let podcast = firstQuerySnapShot.documentID
                let numberEpisode = Int(firstQuerySnapShot.data()["numberEpisode"]
                                        as? String ?? "0") ?? 0
                let randomEpisode = Int.random(in: 1..<numberEpisode-1)
                self.fetchOneEpisodeFirebase(podcast: podcast,
                                             episodeNumber: randomEpisode,
                                             onCompletion: { querySnapshot in
                    onCompletion(querySnapshot)
                })
            }
        })
    }
    
}
