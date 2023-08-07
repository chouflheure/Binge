import Foundation
import AVFoundation
import UIKit

class PlayerAudioService {
    var player = AVPlayer()
    var leftOffPlaybackTime = CMTime()
    
    func play(url: URL) {
        do {
            let playerItem = AVPlayerItem(url: url)
            print("@@@ playing \(url)")
            player = AVPlayer(playerItem: playerItem)
            player.volume = 1
            player.play()
        } catch let error as NSError {
            print("@@@ player = \(error.localizedDescription)")
        }

        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }

    func playResume() {
        print("@@@ play resume")
        do {
            player.seek(to: leftOffPlaybackTime)
            player.play()
        } catch let error as NSError {
            print("@@@ player = \(error.localizedDescription)")
        }
    }

    func pause() {
        print("@@@ pause")
        leftOffPlaybackTime = player.currentTime()
        // leftOffPlaybackTime = CMTimeGetSeconds((player.currentItem?.asset.duration)!)
        print("@@@ leftOffPlaybackTime = \(leftOffPlaybackTime)")
        player.pause()
    }

    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("@@@ The audio file is complete!")
    }

}


class ViewControllerAudioDetail: UIViewController {

    @IBOutlet weak var playChange: UIButton!
    @IBOutlet weak var timeAudio: UILabel!
    @IBOutlet weak var playbackSlider: UISlider!

    var player:AVPlayer?

     override func viewDidLoad() {
         super.viewDidLoad()
         setupAudioPlayer()

     }

     func setupAudioPlayer(){

         let url = URL(string: "https://sphinx.acast.com/a-bientot-de-te-revoir/la-presque-100eme/media.mp3")
         let playerItem = AVPlayerItem(url: url!)
         player = AVPlayer(playerItem:playerItem)
         playbackSlider.tintColor = UIColor.green

         let _ = player!.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: DispatchQueue.main) { [weak self] (time) in
             self?.updateSlider(time: time)
         }

     }

     func updateSlider(time:CMTime){

         let duration = CMTimeGetSeconds(player!.currentItem!.asset.duration)
         self.playbackSlider.value = Float(CMTimeGetSeconds(time)) / Float(duration)
         timeAudio.text = "\(self.playbackSlider.value)"
     }

     @IBAction func play(_ sender: Any) {

         if player?.rate == 0 {

             player?.rate = 1.0;
             player?.play()
             playChange.setImage(Assets.Picto.pause.image, for: .normal)

         } else {

             playChange.setImage(Assets.Picto.Play.play.image, for: .normal)
             player?.pause()

         }
     }

     @IBAction func audioPlaybackSlider(_ sender: Any) {

         //перемотка аудиозвука
         let duration = CMTimeGetSeconds(player!.currentItem!.asset.duration)
         let value = self.playbackSlider.value
         timeAudio.text = "\(self.playbackSlider.value)"
         let durationToSeek = Float(duration) * value

         self.player?.seek(to: CMTimeMakeWithSeconds(Float64(durationToSeek),preferredTimescale: player!.currentItem!.duration.timescale)) { [](state) in

         }

     }

 }


