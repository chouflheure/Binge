
import Foundation
import XCTest
@testable import BingePodcast

class PodcastManagerTests: XCTestCase {
    
    func testFetchAllPodcastFirebaseDone() {
        let mockData: [String: Any] =
        [ "title": "Test_podcast", "image": "test_image_url", "author": "Test_author"]
        
        let fakeResponse = FakeResponse(data: mockData, error: nil)
        let fakeFirebaseSession = FakeFirebaseSession(fakeResponse: fakeResponse)
        let firebaseService = FirebaseService(firebaseManager: fakeFirebaseSession)

        firebaseService.fetchAllPodcastFirebase { result in
            switch result {
            case .success(let podcasts):
                XCTAssertNotNil(podcasts)
                XCTAssertEqual(podcasts?.count, 1)
                XCTAssertTrue(podcasts?.first?.author == "Test_author")
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }
    
    func testFetchAllPodcastFirebaseFailed() {
        let fakeResponse = FakeResponse(data: nil, error: .someError)
        let fakeFirebaseSession = FakeFirebaseSession(fakeResponse: fakeResponse)
        let firebaseService = FirebaseService(firebaseManager: fakeFirebaseSession)

        firebaseService.fetchAllPodcastFirebase { result in
            switch result {
            case .success(let podcasts):
                XCTAssertNil(podcasts)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testFetchOneEpisodeFirebaseDone() {
        let mockData: [String: Any] = ["title": "titleEpisode",
                                           "subtitle": "subtitleEpisode",
                                           "description": "descriptionEpisode",
                                           "totalTime": "totalTimeEpisode",
                                           "imageUrl": "imageUrlEpisode",
                                           "playerUrl": "playerUrlEpisode",
                                           "podcastTitle": "podcastTitleEpisode"]

        let fakeResponse = FakeResponse(data: mockData, error: nil)
        let fakeFirebaseSession = FakeFirebaseSession(fakeResponse: fakeResponse)
        let firebaseService = FirebaseService(firebaseManager: fakeFirebaseSession)
        
        firebaseService.fetchOneEpisodeFirebase(podcast: "PodcastName", episodeNumber: 0, onCompletion: { result in
            switch result {
            case .success(let episode):
                print("@@@ episode = \(episode)")
                XCTAssertNotNil(episode)
            case .failure(let err):
                XCTAssertNil(err)
            }
        })
    }
    
    func testFetchOneEpisodeFirebaseFailed() {
        let fakeResponse = FakeResponse(data: nil, error: .someError)
        let fakeFirebaseSession = FakeFirebaseSession(fakeResponse: fakeResponse)
        let firebaseService = FirebaseService(firebaseManager: fakeFirebaseSession)

        firebaseService.fetchOneEpisodeFirebase(podcast: "PodcastName", episodeNumber: 0, onCompletion: { result in
            switch result {
            case .success(let podcasts):
                XCTAssertNil(podcasts)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        })
    }
    
}

class QueryDocumentSnapshotMock: QueryDocumentSnapShotProtocol {
    public var mockData: [String: Any] = [:]
     
    init(mockData: [String : Any]) {
        self.mockData = mockData
    }
    
    func data() -> [String: Any] {
        return mockData
    }
}





// Créez une classe de mock qui adopte le protocole personnalisé
class QuerySnapshotMock: QuerySnapshotProtocol {
    var queryDoc: [QueryDocumentSnapShotProtocol]
    
    init(queryDoc: [QueryDocumentSnapShotProtocol]) {
        self.queryDoc = queryDoc
    }
}



class FakeFirebaseSession: FirebaseCommande {
    
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
 
    func getDocuments(collectionName: String, completion: @escaping (QuerySnapshotProtocol?, Error?) -> Void) {
        
        var mockDocument = QueryDocumentSnapshotMock(mockData: fakeResponse.data ?? ["":""])
        var query = QuerySnapshotMock(queryDoc: [mockDocument])
        let error = fakeResponse.error
        
        completion(query, error)
    }
    
    func getDocumentsWithLimit(podcastName: String, completion: @escaping (QuerySnapshotProtocol?, Error?) -> Void) {}
}

struct FakeResponse {
    var data: [String: Any]?
    var error: MyCustomError?
}

enum MyCustomError: Error {
    case someError
}


