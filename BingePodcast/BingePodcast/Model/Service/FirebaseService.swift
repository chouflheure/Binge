
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
    
    func fecthAllImagePodcast(imageUrlArray: [String], onCompletion: @escaping (Result<[Data?],Error>) -> Void) {
        var image = [Data?]()

        imageUrlArray.forEach { imageUrlString in
            AF.request( "https://robohash.org/123.png",method: .get).response{ response in

               switch response.result {
                case .success(let responseData):
                    // self.myImageView.image = UIImage(data: responseData!, scale:1)
                   print("@@@ response image : \(responseData)")
                   image.append(responseData)
                   
                case .failure(let error):
                    print("error--->",error)
                }
            }
        }
        
        onCompletion(.success(image))
        
        /*/
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
         */
        
            
        
        }
    
}
