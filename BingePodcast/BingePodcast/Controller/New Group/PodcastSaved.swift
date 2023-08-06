import Foundation

class PodcastSaved {
    var titlePocast = String()
    var episodeSaved = [EpisodeSaved]()
    
    init(titlePocast: String, episodeSaved: [EpisodeSaved]) {
        self.titlePocast = titlePocast
        self.episodeSaved = episodeSaved
    }
}
