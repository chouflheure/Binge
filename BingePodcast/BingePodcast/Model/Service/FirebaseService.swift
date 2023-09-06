import Foundation
import Firebase

public class FirebaseService {
    
    private var arrayLastDocument = [String: DocumentSnapshot]()
    private var limit: Int = 5 // Limite initiale
    private var lastDocument: DocumentSnapshot? = nil
    private var isLoading: Bool = false
    
    private func callFirebase(collectionName: String) -> CollectionReference {
        return Firestore.firestore().collection(collectionName)
    }

    func fetchAllPodcastFirebase(onCompletion: @escaping (Result<[Podcast]?,Error>) -> Void) {
        callFirebase(collectionName: "Podcast").getDocuments() { (querySnapshot, err) in
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
        }
    }
    
    func fetchOneEpisodeFirebase(podcast: String, episodeNumber: Int, onCompletion: @escaping (Episode?) -> Void) {
        
        callFirebase(collectionName: podcast).getDocuments() { (querySnapshot, err) in
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
                                      playerUrl: document.data()["playerUrl"] as? String)
                    onCompletion(episode)
                }
            }
        }
    }
    
    func fetchEpisodeOnPosdcastFirebase(podcastName: String, onCompletion: @escaping (Result<[Episode]?,Error>) -> Void) {

        let query = callFirebase(collectionName: podcastName)
                    .limit(to: limit)

        query.getDocuments() { (querySnapshot, err) in
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
                                           playerUrl: document.data()["playerUrl"] as? String)
                    )
                    
                }
                self.arrayLastDocument[podcastName] = documents.last
                self.lastDocument = documents.last
                onCompletion(.success(episode))
            }
        }
    }
    
    func loadMoreData(podcastName: String, onCompletion: @escaping (Result<[Episode]?,Error>) -> Void) {
        print("@@@ arrayLastDocument = \(arrayLastDocument[podcastName]?.documentID)")
        print("@@@ isLoading = \(isLoading)")
        guard let lastDocument = self.arrayLastDocument[podcastName], !isLoading else {return}
        
        isLoading = true
        
        let query = callFirebase(collectionName: podcastName).start(afterDocument: lastDocument).limit(to: limit)
        
        query.getDocuments { (querySnapshot, error) in
            self.isLoading = false
            if let error = error {
                print("@@@ Erreur lors du chargement des données suivantes : \(error.localizedDescription)")
                onCompletion(.failure(error))
            } else {
                var episode = [Episode]()
                if let documents = querySnapshot?.documents {
                    self.arrayLastDocument[podcastName] = documents.last
                    // self.lastDocument = documents.last // Mettre à jour la dernière référence
                    for document in documents {
                        episode.append(Episode(title: document.data()["title"] as? String,
                                                subtitle: document.data()["subtitle"] as? String,
                                                description: document.data()["description"] as? String,
                                                totalTime: document.data()["totalTime"] as? String,
                                                imageUrl: document.data()["imageUrl"] as? String,
                                                playerUrl: document.data()["playerUrl"] as? String)
                        )
                    }
                    episode.enumerated().forEach { e in
                        print("@@@ episode fetch = \(e.element.subtitle)")
                    }
                }
                onCompletion(.success(episode))
            }
        }
    }

    func fetchAllAuthorFirebase(onCompletion: @escaping ([Author]?) -> Void) {
        callFirebase(collectionName: "Author").getDocuments() { (querySnapshot, err) in
            var author = [Author]()
            if let err = err {
                print("@@@ Error getting: \(err)")
                onCompletion(nil)
            } else {
                for document in querySnapshot!.documents {
                    author.append(Author(image: document.data()["image"] as? String,
                                         name: document.data()["name"] as? String))
                }
                onCompletion(author)
            }
        }
    }

    func fetchRandomPodcast(onCompletion: @escaping (Episode?) -> Void) {
        callFirebase(collectionName: "Podcast").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("@@@ Error getting: \(err)")
                onCompletion(nil)
            } else {
                let podcast = querySnapshot!.documents[0].documentID
                let numberEpisode = Int(querySnapshot!.documents[0].data()["numberEpisode"] as? String ?? "0") ?? 0
                let randomEpisode = Int.random(in: 1..<numberEpisode-1)
                self.fetchOneEpisodeFirebase(podcast: podcast, episodeNumber: randomEpisode, onCompletion: { querySnapshot in
                    onCompletion(querySnapshot)
                })
            }
        }
    }
    
}
