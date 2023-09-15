import XCTest
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
    
    func testDeleteVoidEpisodeMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyAllDeleted() async {
        
        /// create new episode in CoreData
        await coreDataManager.addEpisodeInFavorite(title: "TitleEpisode_1",
                                                   subtitle: "SubtitleEpisode_1",
                                                   description: "DescriptionEpisode_1",
                                                   totalTime: "x_1",
                                                   imageUrl: "https://www.image.png_1",
                                                   playerUrl: "https://player.mp3_1",
                                                   podcastName: "PodcastTitle_1")
        
        await coreDataManager.addEpisodeInFavorite(title: "",
                                                   subtitle: "",
                                                   description: "",
                                                   totalTime: "",
                                                   imageUrl: "",
                                                   playerUrl: "",
                                                   podcastName: "")
        
        /// remove the not void episode
        await coreDataManager.removeEpisodeFromFavorite(titlePodcast: "TitleEpisode_1",
                                                        subtitlePodcast: "SubtitleEpisode_1")
        
        
        /// check if the void episode is delete
        let isFavoriteEpisode = await coreDataManager.checkIfEpisodeIsFavorite(titleEpisode: "",
                                                                               subtitleEpisode: "")
        
        XCTAssertFalse(isFavoriteEpisode)
    }
     
    
    func test() async {
        
        /// create new episode in CoreData for PodcastTitle_1
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
                                                   podcastName: "PodcastTitle_1")
        
        /// create new episode in CoreData for PodcastTitle_2
        await coreDataManager.addEpisodeInFavorite(title: "TitleEpisode_3",
                                                   subtitle: "SubtitleEpisode_3",
                                                   description: "DescriptionEpisode_3",
                                                   totalTime: "x_3",
                                                   imageUrl: "https://www.image.png_3",
                                                   playerUrl: "https://player.mp3_3",
                                                   podcastName: "PodcastTitle_2")
        
        /// remove the not void episode
        let arrayPodcast = coreDataManager.fetchFavoriteEpisode()
        var podcastFirst = PodcastEpisode(podcast: Podcast(title: "", image: "", author: ""), episode: [Episode(title: "", subtitle: "", description: "", totalTime: "", imageUrl: "", playerUrl: "", podcastTitle: "")])

        print("@@@ arrayPodcast.first?.podcast.title = \(arrayPodcast.first?.podcast.title)")
        
        if arrayPodcast.first?.podcast.title == "PodcastTitle_1" {
            XCTAssertTrue(arrayPodcast.first?.episode.count == 2)
            podcastFirst = arrayPodcast.first!
        } else {
            XCTAssertTrue(arrayPodcast.first?.episode.count == 1)
        }

        if podcastFirst.episode.first?.title == "TitleEpisode_1" {
            XCTAssertTrue(podcastFirst.episode.last?.title == "TitleEpisode_1")
        } else if podcastFirst.episode.first?.title == "TitleEpisode_2" {
            XCTAssertTrue(podcastFirst.episode.last?.title == "TitleEpisode_2")
        } else if podcastFirst.podcast.title == "" {
            XCTAssertTrue( arrayPodcast.first?.episode.first?.title == "TitleEpisode_3")
        }
        
        
//        XCTAssertTrue(!coreDataManager.arrayPodcastEpisode.isEmpty)
//        XCTAssertTrue(lastEpisodeSaved.episode.last?.totalTime == "x")
//        XCTAssertTrue(lastEpisodeSaved.podcast.title == "PodcastTitle")
//        XCTAssertTrue(lastEpisodeSaved.episode.last?.title == "TitleEpisode")
//        XCTAssertTrue(lastEpisodeSaved.episode.last?.subtitle == "SubtitleEpisode")
//        XCTAssertTrue(lastEpisodeSaved.episode.last?.playerUrl == "https://player.mp3")
//        XCTAssertTrue(lastEpisodeSaved.episode.last?.description == "DescriptionEpisode")
//        XCTAssertTrue(lastEpisodeSaved.episode.last?.imageUrl == "https://www.image.png")
        
        
        /// check if the void episode is delete
        let isFavoriteEpisode = await coreDataManager.checkIfEpisodeIsFavorite(titleEpisode: "",
                                                                               subtitleEpisode: "")
        
        XCTAssertFalse(isFavoriteEpisode)
    }
}
