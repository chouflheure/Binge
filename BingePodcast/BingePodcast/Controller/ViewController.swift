//
//  ViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 04/06/2023.
//


import UIKit
import Firebase
import AVFoundation

class ViewController: UIViewController {

    var testAudio = PlayerAudioService()
    var leftOffPlaybackTime = CMTime()
    let urlString = "https://stitcher2.acast.com/livestitches/bbe1ca92c249797cc5d3b00e95997672.mp3?aid=647eed82aa1f1000114bf3fd&chid=debd25e1-aef9-4791-b8eb-b4088df51216&ci=hyKS-uZkK1Hn3hmhCk_ZEOjzkzKK0B_EPRWst2KZjlqy3tvbJZx-XQ%3D%3D&pf=embed&sv=sphinx%401.162.0&uid=7b8bbbb0a52677cd6c4235cfb01b229e&Expires=1686501659522&Key-Pair-Id=K38CTQXUSD0VVB&Signature=BtLVlntJxPVneLaWpv5bMVq2yN5NE3rmNpROQziozJDWhdDL2tda-aKu-of1kbH3T5mSwW0Ef9Xiyu5~2r2JgqYkRgv4mBfCvHm8SDD98muM9BMcyPNLFwSk--cPswJAwP8GxHcpkQQ~hMZSaplu8gV8QeCAMW-XqCkg9xY7sURxrBWNtPWN-0W24ZhngkmsXvBwhhc4uJL8zf~80ktYQuvGaHebIxf1LIT1xXGFhbkzvz6OEFkDWieQSqqDPAAmOxy2uTc01ivYAyvlBR~gokER96RuhVK1fzQH71EI64-VXaeBvulhzjDjOetGtEJG1uzwLEN22~r5bWn5WWjvDw__"



    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            // try await testFecthDataOnPosdcastFirebase()
            // try await testFecthAllPodcast()
        }
        
        molecule1()
        testAudio.play(url: URL(string: urlString)!)
    }


    @IBAction func playBtn(_ sender: Any) {
        testAudio.playResume()
    }

    @IBAction func pause(_ sender: Any) {
        testAudio.pause()
    }

    func testFecthDataOnPosdcastFirebase() async throws {
        do {
            let data = try await Firestore.firestore().collection("Podcast").document("À bientôt de te revoir").getDocument()
            // guard let data = data else {return}
            print("@@@ ici = \(data["name"] ?? "")")
        } catch let e {
            print("@@@ error = \(e)")
        }
    }

    func testFecthAllPodcast() async throws {
        do {
            let data = try await Firestore.firestore().collection("Podcast").getDocuments()// .document("Programme B").getDocument()
            print("@@@ ici = \(data.documents[0].documentID)")
        } catch let e {
            print("@@@ error = \(e)")
        }
    }

    
    func molecule1() {
        let container = UIView()
        view.addSubview(container)
       
        view.backgroundColor = .blue
        container.backgroundColor = .gray

        /// size and center
        container.translatesAutoresizingMaskIntoConstraints = false
        [
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.widthAnchor.constraint(equalToConstant: view.frame.width - 60.0),
            container.heightAnchor.constraint(equalToConstant: 100)
        ].forEach{ $0.isActive = true }
        
        /// circle bounds
        container.layer.cornerRadius = 50
        
        let test = UIView()
        
        view.addSubview(test)
        test.translatesAutoresizingMaskIntoConstraints = false
        [
            test.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 6),
            test.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            //test.widthAnchor.constraint(equalToConstant: view.frame.width - 66.0),
            test.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -6),
            test.heightAnchor.constraint(equalToConstant: 88)
        ].forEach{ $0.isActive = true }
        
        test.layer.cornerRadius = 46
        
        // test.layer.shadowOffset = CGSize(width: 10, height: 0)
        test.layer.shadowColor = UIColor.black.withAlphaComponent(1).cgColor
        test.layer.shadowOpacity = 0.6
        test.layer.shadowRadius = 1
        test.layer.masksToBounds = false
        // test.layer.borderWidth = 1

        test.backgroundColor = .yellow.withAlphaComponent(0.7)

        let testView = UIView()
        view.addSubview(testView)
        testView.translatesAutoresizingMaskIntoConstraints = false
        [
            testView.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 6),
            testView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            testView.widthAnchor.constraint(equalToConstant: 88),
            testView.heightAnchor.constraint(equalToConstant: 88)
        ].forEach{ $0.isActive = true }
        
        testView.layer.cornerRadius = 45
        testView.backgroundColor = .green
    }
    
    func image() {
        
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

