import XCTest
import Firebase

@testable import BingePodcast // Assurez-vous d'importer votre module ici
/*
class MockFireBaseManager: FirebaseCommande {
    func getDocuments(collectionName: String, completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        
    }
    func getDocumentsWithLimit(podcastName: String, completion: @escaping (QuerySnapshot?, Error?) -> Void) {}
    func getDocumentsWithLimitAndStart(podcastName: String, completion: @escaping (QuerySnapshot?, Error?) -> Void) {}
}

class FirebaseServiceTests: XCTestCase {

    func testFetchAllPodcastFirebaseSuccess() {
         
        // Créez une instance de FirebaseService
        let firebaseService = FirebaseService(firebaseManager: FirebaseManager())
        
        // Créez un mock de Firestore qui retournera des données fictives
        let firestoreMock = FirestoreMock()

        // Injectez le mock de Firestore dans FirebaseService

        // Définissez des données fictives pour le mock de Firestore
        firestoreMock.mockData = [
            "Podcast": [
                ["title": "Podcast 1", "image": "image1.jpg", "author": "Author 1"],
                ["title": "Podcast 2", "image": "image2.jpg", "author": "Author 2"]
            ]
        ]

        // Créez une expectation pour vérifier le résultat du test
        let expectation = XCTestExpectation(description: "Fetch podcast data")
        
        
        
/*
        // Appelez la méthode fetchAllPodcastFirebase
        firebaseService.fetchAllPodcastFirebase { result in
            switch result {
            case .success(let podcasts):
                XCTAssertNotNil(podcasts)
                XCTAssertEqual(podcasts?.count, 2)
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            expectation.fulfill()
        }

        // Attendre que l'expectation soit remplie
        wait(for: [expectation], timeout: 5.0)
 */
    }
 
}

// Créez un mock de Firestore pour simuler les appels à Firestore
class FirestoreMock {
    var mockData: [String: Any] = [:]

   
}
*/
