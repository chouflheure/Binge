import Foundation

class PodcastSaved {
    var titlePocast = String()
    var episodeSaved = [EpisodeSaved_test]()
    
    init(titlePocast: String, episodeSaved: [EpisodeSaved_test]) {
        self.titlePocast = titlePocast
        self.episodeSaved = episodeSaved
    }
}
