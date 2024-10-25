
import UIKit
import AVFoundation

var player : AVAudioPlayer! = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")!)

class ViewController: UIViewController {
    let eggTimes : [String : Int] = ["Soft" : 300 ,"Medium" : 420 , "Hard" : 720 ]
    
    var isEnabled = Timer()
    
    func timer(timeNeeded : Int,selectedSoftness : String) {
        var totalTime = timeNeeded //300
        var secondsPassed : Float = 0
        var progress : Float = 0
        isEnabled = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if totalTime > 0 {
                if player.isPlaying {
                    player.stop()
                }
                self.secondsCounter.text =  "\(totalTime) seconds left"
                self.progressBar.progress = progress
                totalTime -= 1
                self.topTitle.text = selectedSoftness
                secondsPassed += 1
                progress = secondsPassed / Float(timeNeeded)
            } else {
                self.topTitle.text = "Done!"
                 player.play()
                self.secondsCounter.text = "Bon Àpetit"
                self.progressBar.progress = 1
                Timer.invalidate()
            }
        }
    }
    @IBOutlet weak var secondsCounter: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var topTitle: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        if isEnabled.isValid {
            isEnabled.invalidate()
            timer(timeNeeded : eggTimes[hardness]! , selectedSoftness: hardness)
        } else {
            timer(timeNeeded : eggTimes[hardness]! , selectedSoftness: hardness)
        }
    }
}
