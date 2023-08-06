
import UIKit
import Firebase
import AVFoundation

class ViewController: UIViewController {

    var testAudio = PlayerAudioService()
    var leftOffPlaybackTime = CMTime()
    let urlString = "https://sphinx.acast.com/a-bientot-de-te-revoir/la-presque-100eme/media.mp3"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: urlString)!
        testAudio.play(url: url)
        
    }

    @IBAction func playBtn(_ sender: Any) {
        testAudio.playResume()
    }
    
    @IBAction func pauseBtn(_ sender: Any) {
        testAudio.pause()
    }
    

    
    
    /*
    
    func initAudioPlayer{
        let url = URL(string: "https://argaamplus.s3.amazonaws.com/eb2fa654-bcf9-41de-829c-4d47c5648352.mp3")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        playbackSlider.minimumValue = 0
        
        //To get overAll duration of the audio
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        labelOverallDuration.text = self.stringFromTimeInterval(interval: seconds)
        
        //To get the current duration of the audio
        let currentDuration : CMTime = playerItem.currentTime()
        let currentSeconds : Float64 = CMTimeGetSeconds(currentDuration)
        labelCurrentTime.text = self.stringFromTimeInterval(interval: currentSeconds)
        
        playbackSlider.maximumValue = Float(seconds)
        playbackSlider.isContinuous = true
        
        
        
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.player!.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
                self.playbackSlider.value = Float ( time );
                self.labelCurrentTime.text = self.stringFromTimeInterval(interval: time)
            }
            let playbackLikelyToKeepUp = self.player?.currentItem?.isPlaybackLikelyToKeepUp
            if playbackLikelyToKeepUp == false{
                print("IsBuffering")
                self.ButtonPlay.isHidden = true
                //        self.loadingView.isHidden = false
            } else {
                //stop the activity indicator
                print("Buffering completed")
                self.ButtonPlay.isHidden = false
                //        self.loadingView.isHidden = true
            }
        }
       
       //change the progress value
        playbackSlider.addTarget(self, action: #selector(playbackSliderValueChanged(_:)), for: .valueChanged)
        
        //check player has completed playing audio
        NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)}


    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider) {
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        player!.seek(to: targetTime)
        if player!.rate == 0 {
            player?.play()
        }
    }

    @objc func finishedPlaying( _ myNotification:NSNotification) {
        ButtonPlay.setImage(UIImage(named: "play"), for: UIControl.State.normal)
        //reset player when finish
        playbackSlider.value = 0
        let targetTime:CMTime = CMTimeMake(value: 0, timescale: 1)
        player!.seek(to: targetTime)
    }

    @IBAction func playButton(_ sender: Any) {
        print("play Button")
        if player?.rate == 0
        {
            player!.play()
            self.ButtonPlay.isHidden = true
            //        self.loadingView.isHidden = false
            ButtonPlay.setImage(UIImage(systemName: "pause"), for: UIControl.State.normal)
        } else {
            player!.pause()
            ButtonPlay.setImage(UIImage(systemName: "play"), for: UIControl.State.normal)
        }
        
    }


    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }



    @IBAction func seekBackWards(_ sender: Any) {
        if player == nil { return }
        let playerCurrenTime = CMTimeGetSeconds(player!.currentTime())
        var newTime = playerCurrenTime - seekDuration
        if newTime < 0 { newTime = 0 }
        player?.pause()
        let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        player?.seek(to: selectedTime)
        player?.play()

    }


    @IBAction func seekForward(_ sender: Any) {
        if player == nil { return }
        if let duration = player!.currentItem?.duration {
           let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
           let newTime = playerCurrentTime + seekDuration
           if newTime < CMTimeGetSeconds(duration)
           {
              let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as
           Float64), timescale: 1000)
              player!.seek(to: selectedTime)
           }
           player?.pause()
           player?.play()
          }
    }

     */
}

