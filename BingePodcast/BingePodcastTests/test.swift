import XCTest

@testable import BingePodcast // Assurez-vous d'importer votre module ici
/*
class FirebaseServiceTests: XCTestCase {

    func testFetchAllPodcastFirebaseSuccess() {
        // Créez une instance de FirebaseService
        let firebaseService = FirebaseService()

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
    }

    // Vous pouvez ajouter d'autres tests ici, par exemple, pour gérer les cas d'erreur.
}

// Créez un mock de Firestore pour simuler les appels à Firestore
class FirestoreMock {
    var mockData: [String: Any] = [:]

   
}
*/
