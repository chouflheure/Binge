//
//  test2.swift
//  BingePodcastTests
//
//  Created by charlesCalvignac on 20/09/2023.
//

import Foundation
import XCTest
@testable import BingePodcast

protocol QueryDocumentSnapshotProtocol {
    func data() -> [String: Any]?
}


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
        
        let mockSnapshot = MockQueryDocumentSnapshot(mockData: mockData)
        
        // Utilisez le mockSnapshot dans la méthode fetchAllPodcastFirebase
        let expectation = XCTestExpectation(description: "Fetch Podcasts")
        
        firebaseService.fetchAllPodcastFirebase { result in
            switch result {
            case .success(let podcasts):
                print("@@@ podcasts?.first?.title = \(podcasts?.first?.title)")
                XCTAssertNotNil(podcasts)
                XCTAssertEqual(podcasts?.count, 1) // Vérifiez le nombre de podcasts récupérés
                // Vous pouvez ajouter d'autres assertions ici pour vérifier les détails des podcasts récupérés.
                
            case .failure(let error):
                XCTFail("Fetching podcasts failed with error: \(error)")
            }
            
            expectation.fulfill()
        }
    }

    
}

class MockQueryDocumentSnapshot: QueryDocumentSnapshotProtocol {
    private let mockData: [String: Any]

    init(mockData: [String: Any]) {
        self.mockData = mockData
    }

    func data() -> [String: Any]? {
        return mockData
    }
}
