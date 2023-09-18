
import XCTest
@testable import BingePodcast

class ImageCallURLTests: XCTestCase {
    
    func testDownloadImageWithValidURL() {
        let imageDownloader = ImageCallURL()
        let expectation = self.expectation(description: "Download image with valid URL")
        
        let validURL = "https://back.bingeaudio.fr/wp-content/uploads/2021/07/soundcloud_cover_102-768x768.png"
        imageDownloader.downloadImage(validURL) { (image, urlString) in
            XCTAssertNotNil(image)
            XCTAssertEqual(urlString, validURL)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDownloadImageWithInvalidURL() {
        let imageDownloader = ImageCallURL()
        let expectation = self.expectation(description: "Download image with invalid URL")
        
        let invalidURL = "invalid-url"
        imageDownloader.downloadImage(invalidURL) { (image, urlString) in
            XCTAssertNil(image)
            XCTAssertEqual(urlString, invalidURL)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
