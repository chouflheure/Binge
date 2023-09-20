/*
import Foundation
import XCTest
@testable import BingePodcast

class Test: XCTest {
    
    func test1() {
        
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
*/
*/
