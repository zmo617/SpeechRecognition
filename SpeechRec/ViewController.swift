//
//  ViewController.swift
//  SpeechRec
//
//  Created by Claire Mo on 6/8/20.
//  Copyright © 2020 Zongying Mo. All rights reserved.
//

import UIKit
import Speech
import AVFoundation
class ViewController: UIViewController, AVAudioPlayerDelegate {
    //AVAudioPlayerDelegate can tell if the audio is finished
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activitySpinner.isHidden = true
        
    }
    
    
    @IBAction func startButtonTapped(_ sender: Any) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
    }
    
    //tells if the audio is finished
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    
    func requestSpeechAuth(){
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized{
                //path for audio file
                if let path = Bundle.main.url(forResource: "SampleMemo", withExtension: "mp3"){
                    //try playing the audio
                    do{
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        //need to tell the audioPlayer it has a delegate
                        self.audioPlayer.delegate = self
                        sound.play()
                    }catch{
                        print("ERROR!!")
                    }
                    //set up a recognizer
                    let recognizer = SFSpeechRecognizer()
                    //set up a request
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request){(result, error) in
                        if let error = error{
                            print("There is a \(error)")
                        }else{
                            //print(result?.bestTranscription.formattedString)
                            //put it into the field text box
                            self.textField.text = result?.bestTranscription.formattedString
                        }
                    }
                }
            }
        }
    }
}
