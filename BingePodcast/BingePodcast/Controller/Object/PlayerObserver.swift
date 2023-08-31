import Foundation

class PlayerObserver {

    static let sharedInstance = PlayerObserver()

    private var imagePodcastString = String()
    private var titlePodcastString = String()
    private var subtitlePodcastString = String()
    private var isPlaying = Bool()

    private init() {}

    func pushPodcastDataPlaying(imagePodcastString: String, titlePodcastString: String, subtitlePodcastString: String) -> PlayerObserver {
        self.imagePodcastString = imagePodcastString
        self.titlePodcastString = titlePodcastString
        self.subtitlePodcastString = subtitlePodcastString
        return self
    }

    func getPodcastPlayingData() {
        print("@@@ Hello \(titlePodcastString)")
    }
}
