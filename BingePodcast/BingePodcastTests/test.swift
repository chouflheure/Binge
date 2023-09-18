
import XCTest
import Firebase
@testable import BingePodcast // Assurez-vous d'importer votre module ici


class Test: XCTest {
    
    func test1() {
        
        if ProcessInfo.processInfo.environment["unit_tests"] == "true" {
          print("Setting up Firebase emulator localhost:8080")
          let settings = Firestore.firestore().settings
          settings.host = "localhost:8080"
          settings.isSSLEnabled = false
          Firestore.firestore().settings = settings
        }
        
        let documentData: [String: Any] = [
            "fieldName": "fieldValue",
            "otherField": 123,
             // Add other fields as needed for your test
        ]
        let fakeResponse = FakeResponse(data: documentData, error: nil)
        let fakeFirebaseSession = FakeFirebaseSession(fakeResponse: fakeResponse)
        
        let firebase = FirebaseService(firebaseManager: fakeFirebaseSession)
        firebase.fetchAllPodcastFirebase(onCompletion: { test in
            print("@@@ test = \(test)")
            XCTAssertTrue(true)
            
            
        })
        
        XCTAssertTrue(true)
        
    }
    
}

class FakeFirebaseSession: FirebaseCommande {
    
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    func getDocuments(collectionName: String, completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        var mockDocument: QueryDocumentSnapshotMock?
        mockDocument?.mockData = fakeResponse.data
        mockDocument?.mockDocumentID = ""
        guard let mockDocument = mockDocument else {return}
        
        var querySnapShot: QuerySnapshotMock?
        querySnapShot?.mockDocuments = [mockDocument]
        guard let querySnapShot = querySnapShot else {return}
        
        let error = fakeResponse.error
        
        completion(querySnapShot, error)
    }
    
    func getDocumentsWithLimit(podcastName: String, completion: @escaping (QuerySnapshot?, Error?) -> Void) {}
}

struct FakeResponse {
    var data: [String: Any]
    var error: Error?
}



class QueryDocumentSnapshotMock: QueryDocumentSnapshot {
    public var mockData: [String: Any]
    public var mockDocumentID: String
    
    override func data() -> [String: Any] {
        return mockData
    }
   
    override var documentID: String {
        return mockDocumentID
    }
}

class QuerySnapshotMock: QuerySnapshot {
    public var mockDocuments: [QueryDocumentSnapshotMock]
    
    override var documents: [QueryDocumentSnapshot] {
        return mockDocuments
    }
    
    override var count: Int {
        return mockDocuments.count
    }
}

/*

class MockFireBaseManager: FirebaseCommande {
    func getDocuments(collectionName: String, completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        let documentData: [String: Any] = [
            "fieldName": "fieldValue",
            "otherField": 123,
             // Add other fields as needed for your test
        ]
        let mockDocument = QueryDocumentSnapshotMock(data: documentData, documentID: "documentID")
        let querySnapShot = QuerySnapshotMock(documents: [mockDocument])
         
        completion(querySnapShot, nil)
    }
    func getDocumentsWithLimit(podcastName: String, completion: @escaping (QuerySnapshot?, Error?) -> Void) {}
 }

class FirebaseServiceTests: XCTestCase {

    func testFetchAllPodcastFirebaseSuccess() {

        // Créez une instance de FirebaseService
        let firebaseService = FirebaseService(firebaseManager: MockFireBaseManager())
        
        let fakeResponse = FakeResponse(response: nil, data: nil, error: nil)
        // Créez un mock de Firestore qui retournera des données fictives
        firebaseService.firebaseManager.getDocuments(collectionName: "") { (querySnapshot, err) in
            // test here des résultats 
            querySnapshot?.documents.first?.data()["fieldName"]
        }
        
        

        
        // Injectez le mock de Firestore dans FirebaseService

        // Définissez des données fictives pour le mock de Firestore
        /*
        firestoreMock.mockData = [
            "Podcast": [
                ["title": "Podcast 1", "image": "image1.jpg", "author": "Author 1"],
                ["title": "Podcast 2", "image": "image2.jpg", "author": "Author 2"]
            ]
        ]
*/
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

class FirestoreTests: XCTestCase {
    
    var firestore: Firestore!
    
    override func setUp() {
        super.setUp()
        // Initialize Firestore with a custom Firebase App for testing (replace with your own Firebase configuration)
        let settings = FirestoreSettings()
        settings.host = "localhost:8080" // Use Firestore emulator if available
        let firestore = Firestore.firestore()
        firestore.settings = settings
        self.firestore = firestore
    }
    
    override func tearDown() {
        super.tearDown()
        // Clean up any Firestore-related resources
    }
    
    func testQuerySnapshotConstruction() {
        // Assume you have a Firestore collection named "testCollection"
        let collectionReference = firestore.collection("testCollection")
        
        // Create a Query
        let query = collectionReference.whereField("fieldName", isEqualTo: "fieldValue")
        
        // Create a QuerySnapshot with some mock data
        let documentData: [String: Any] = [
            "fieldName": "fieldValue",
            "otherField": 123,
            // Add other fields as needed for your test
        ]
        
        let mockDocument: QueryDocumentSnapshotMock
        mockDocument.mockData = documentData
        mockDocument.mockDocumentID = "documentID"
    
        let mockQuerySnapshot: QuerySnapshotMock
        mockQuerySnapshot.documents = [mockDocument]
        // Now you can use `mockQuerySnapshot` in your test code
        XCTAssertEqual(mockQuerySnapshot.count, 1)
        // Perform assertions or testing logic here
        
        // Example: Check if the first document in the snapshot has the expected data
        let firstDocument = mockQuerySnapshot.documents.first
        // XCTAssertEqual(firstDocument?.data(), documentData)
        XCTAssertEqual(firstDocument?.documentID, "documentID")
    }
}

// Mock classes to simulate QueryDocumentSnapshot and QuerySnapshot
class QueryDocumentSnapshotMock: QueryDocumentSnapshot {
    public var mockData: [String: Any]
    public var mockDocumentID: String
    
    override func data() -> [String: Any] {
        return mockData
    }
    
    override var documentID: String {
        return mockDocumentID
    }
}

class QuerySnapshotMock: QuerySnapshot {
    public var mockDocuments: [QueryDocumentSnapshotMock]
    
    override var documents: [QueryDocumentSnapshot] {
        return mockDocuments
    }
    
    override var count: Int {
        return mockDocuments.count
    }
}

*/
