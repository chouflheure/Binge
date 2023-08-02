
import Foundation
import Firebase
import Alamofire

public class FirebaseService {
    
    private func callFirebase(collectionName: String) -> CollectionReference {
        return Firestore.firestore().collection(collectionName)
    }

    func fetchAllPodcastFirebase(onCompletion: @escaping (Result<[Podcast]?,Error>) -> Void) {
        callFirebase(collectionName: "Podcast").getDocuments() { (querySnapshot, err) in
            var podcast = [Podcast]()
            if let err = err {
                print("@@@ Error getting: \(err)")
                onCompletion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
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
    
    
    func fetchDataOnPosdcastFirebase(onCompletion: @escaping ([Episode]?) -> Void) {
        callFirebase(collectionName: "Du Sport").getDocuments() { (querySnapshot, err) in
            var episode = [Episode]()
            if let err = err {
                print("@@@ Error getting: \(err)")
                onCompletion(nil)
            } else {
                for document in querySnapshot!.documents {
                    episode.append(Episode(title: document.data()["title"] as? String,
                                           subtitle: document.data()["subtitle"] as? String,
                                           description: document.data()["description"] as? String,
                                           totalTime: document.data()["totalTime"] as? String,
                                           imageUrl: document.data()["imageUrl"] as? String,
                                           playerUrl: document.data()["playerUrl"] as? String)
                    )
                }
                onCompletion(episode)
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
