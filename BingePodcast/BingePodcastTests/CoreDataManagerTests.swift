import XCTest
import Firebase
@testable import BingePodcast

final class CoreDataManagerTests: XCTestCase {
    
    // MARK: - Properties
    
    var coreDataManager: CoreDataManager!
    
    // MARK: - Tests Life Cycle
    
    override func setUp() {
        super.setUp()
        self.coreDataManager = CoreDataManager(coreDataStack: CoreDataStack(modelName: "BingePodcast",
                                                                            useInMemoryStore: true))
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
    }
    
    // MARK: - Tests
    
    func testAddRecipeMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() async {
        
        /// create episode in CoreData
        await coreDataManager.addEpisodeInFavorite(title: "TitleEpisode",
                                                   subtitle: "SubtitleEpisode",
                                                   description: "DescriptionEpisode",
                                                   totalTime: "x",
                                                   imageUrl: "https://www.image.png",
                                                   playerUrl: "https://player.mp3",
                                                   podcastName: "PodcastTitle")
        
        guard let lastEpisodeSaved = coreDataManager.arrayPodcastEpisode.last else {return}
        
        XCTAssertTrue(!coreDataManager.arrayPodcastEpisode.isEmpty)
        XCTAssertTrue(lastEpisodeSaved.episode.last?.totalTime == "x")
        XCTAssertTrue(lastEpisodeSaved.podcast.title == "PodcastTitle")
        XCTAssertTrue(lastEpisodeSaved.episode.last?.title == "TitleEpisode")
        XCTAssertTrue(lastEpisodeSaved.episode.last?.subtitle == "SubtitleEpisode")
        XCTAssertTrue(lastEpisodeSaved.episode.last?.playerUrl == "https://player.mp3")
        XCTAssertTrue(lastEpisodeSaved.episode.last?.description == "DescriptionEpisode")
        XCTAssertTrue(lastEpisodeSaved.episode.last?.imageUrl == "https://www.image.png")
        
        /// check if recipe is save in favorite
        let episodeIsFavorite = await coreDataManager
            .checkIfEpisodeIsFavorite(titleEpisode: "TitleEpisode",subtitleEpisode: "SubtitleEpisode")
        
        XCTAssertTrue(coreDataManager.arrayPodcastEpisode.count > 0)
        XCTAssertTrue(episodeIsFavorite)
    }
    
    func testDeleteEpisodeMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() async {
        await coreDataManager.addEpisodeInFavorite(title: "TitleEpisode_1",
                                                   subtitle: "SubtitleEpisode_1",
                                                   description: "DescriptionEpisode_1",
                                                   totalTime: "x_1",
                                                   imageUrl: "https://www.image.png_1",
                                                   playerUrl: "https://player.mp3_1",
                                                   podcastName: "PodcastTitle_1")
        
        await coreDataManager.addEpisodeInFavorite(title: "TitleEpisode_2",
                                                   subtitle: "SubtitleEpisode_2",
                                                   description: "DescriptionEpisode_2",
                                                   totalTime: "x_2",
                                                   imageUrl: "https://www.image.png_2",
                                                   playerUrl: "https://player.mp3_2",
                                                   podcastName: "PodcastTitle_2")
        
        /// remove recipe
        await coreDataManager.removeEpisodeFromFavorite(titlePodcast: "TitleEpisode_1",
                                                        subtitlePodcast: "SubtitleEpisode_1")
        
        /// check if episodes are in favorite
        let episodeIsFavorite_1 = await coreDataManager
            .checkIfEpisodeIsFavorite(titleEpisode: "TitleEpisode_1",
                                      subtitleEpisode: "SubtitleEpisode_1")
        
        XCTAssertFalse(episodeIsFavorite_1)
        
        let episodeIsFavorite_2 = await coreDataManager
            .checkIfEpisodeIsFavorite(titleEpisode: "TitleEpisode_2",
                                      subtitleEpisode: "SubtitleEpisode_2")
        XCTAssertTrue(episodeIsFavorite_2)
        
        XCTAssertFalse(coreDataManager.arrayPodcastEpisode.isEmpty)
        
    }
}
