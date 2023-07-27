
import Foundation

class EpisodeSaved {
    var titleEpisode = String()
    var subtitleEpisode = String()
    var totalTimeEpisode = String()
    var favorite = Bool()
    var imageEpisode = String()
    
    init(titleEpisode: String, subtitleEpisode: String, totalTimeEpisode: String, favorite: Bool, imageEpisode: String) {
        self.titleEpisode = titleEpisode
        self.subtitleEpisode = subtitleEpisode
        self.totalTimeEpisode = totalTimeEpisode
        self.favorite = favorite
        self.imageEpisode = imageEpisode
    }
}
