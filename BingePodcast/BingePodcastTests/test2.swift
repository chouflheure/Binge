//
//  test2.swift
//  BingePodcastTests
//
//  Created by charlesCalvignac on 20/09/2023.
//

import Foundation
import XCTest
import Firebase
@testable import BingePodcast



class PodcastManagerTests: XCTestCase {
    
    func testFetchAllPodcastFirebase() {
        // let podcastManager = PodcastManager()
        let firebaseService = FirebaseService(firebaseManager: FirebaseManager())
        
        // Créez un MockQueryDocumentSnapshot simulé avec des données de podcast
        let mockData: [String: Any] = [
            "title": "Test Podcast",
            "image": "test_image_url",
            "author": "Test Author"
        ]
        
        let fakeResponse = FakeResponse(data: mockData, error: nil)
        let fakeFirebaseSession = FakeFirebaseSession(fakeResponse: fakeResponse)
        
        let firebase = FirebaseService(firebaseManager: fakeFirebaseSession)
        
                
        // Utilisez le mockSnapshot dans la méthode fetchAllPodcastFirebase
        let expectation = XCTestExpectation(description: "Fetch Podcasts")
        
        let test = [Podcast(title: "title", image: "image", author: "author")]
        
        firebase.fetchAllPodcastFirebase { result in
            switch result {
            case .success(let podcasts):
                XCTAssertNotNil(podcasts)
                XCTAssertEqual(podcasts?.count, 1)
                // Vous pouvez ajouter d'autres assertions ici pour vérifier les détails des podcasts récupérés.
                
            case .failure(let error):
                XCTFail("Fetching podcasts failed with error: \(error)")
            }
            
            expectation.fulfill()
        }
    }
}

class MockQueryDocumentSnapshotMock: QueryDocumentSnapshotProtocol {
    func data() -> [String : Any] {
        return mockData
    }
    
    private let mockData: [String: Any]

    init(mockData: [String: Any]) {
        self.mockData = mockData
    }

    func data() -> [String: Any]? {
        return mockData
    }
}





// Créez une classe de mock qui adopte le protocole personnalisé
class QuerySnapshotMock: QuerySnapshotProtocol {

    var documents: [QueryDocumentSnapshot]
    
    init(documents: [QueryDocumentSnapshot]) {
        self.documents = documents
    }
}



class FakeFirebaseSession: FirebaseCommande {
    
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
 
    func getDocuments(collectionName: String, completion: @escaping (QuerySnapshotProtocol?, Error?) -> Void) {
        var mockDocument = QueryDocumentSnapshotMock(mockData: fakeResponse.data)
        
        var querySnapShot = QuerySnapshotMock(documents: [mockDocument])
        
        let error = fakeResponse.error
        
        completion(querySnapShot, error)
    }
    
    func getDocumentsWithLimit(podcastName: String, completion: @escaping (QuerySnapshotProtocol?, Error?) -> Void) {}
}

struct FakeResponse {
    var data: [String: Any]
    var error: Error?
}

protocol QueryDocumentSnapshotProtocol {
    func data() -> [String: Any]
    // Ajoutez d'autres méthodes ou propriétés si nécessaire
}

extension QueryDocumentSnapshot: QueryDocumentSnapshotProtocol {}

class QueryDocumentSnapshotMock: QueryDocumentSnapshotProtocol {
    public var mockData: [String: Any] = [:]
     
    init(mockData: [String : Any]) {
        self.mockData = mockData
    }
    
    func data() -> [String: Any] {
        return mockData
    }
}


