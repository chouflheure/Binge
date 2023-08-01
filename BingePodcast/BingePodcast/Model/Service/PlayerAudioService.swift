
import Foundation
import AVFoundation

class PlayerAudioService {
    var testAudio = AVPlayer()
    var leftOffPlaybackTime = CMTime()
    
    
    
    func play(url: URL) {
        print("@@@ playing \(url)")

        do {
            let playerItem = AVPlayerItem(url: url)

            testAudio = AVPlayer(playerItem: playerItem)
            testAudio.volume = 0
            testAudio.play()
        } catch let error as NSError {
            print("@@@ player = \(error.localizedDescription)")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: testAudio.currentItem)
    }
    
    func playResume() {
        do {

            self.testAudio.seek(to: leftOffPlaybackTime)
            testAudio.play()

        } catch let error as NSError {
            print("@@@ player = \(error.localizedDescription)")
        }
    }
    
    func pause() {
        leftOffPlaybackTime = testAudio.currentTime()
        testAudio.pause()
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("@@@ The audio file is complete!")
    }

}
