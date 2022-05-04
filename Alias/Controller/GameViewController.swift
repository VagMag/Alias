//
//  GameViewController.swift
//  Alias
//
//  Created by Maxim Vagin on 02.05.2022.
//

import UIKit

enum Status: CaseIterable {
    case correct, incorrect, elapsed, waiting
}

class GameViewController: UIViewController {
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var incorrectButton: UIButton!
    
    var status: Status = .waiting{
        didSet {
            if case .waiting = status {
                timeRemaining = 60
                timer?.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    self.statusUpdater(self.status)
                    if self.timeRemaining == 0 {
                        timer.invalidate()
                        self.status = .elapsed
                    }
                    self.timeRemaining -= 1
                }
                timer?.tolerance = 0.2
            } else {
                timer?.invalidate()
                statusUpdater(status)
            }
        }
    }
    private var timeRemaining = 60
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        status = .waiting
    }
    
    private func statusUpdater(_ status: Status) {
        switch status {
        case .correct:
            disableAnswerButtons()
            animateBackgroundChanged(for: correctButton, to: .systemMint)
            timeRemainingLabel.text = "Correct"
        case .incorrect:
            disableAnswerButtons()
            animateBackgroundChanged(for: incorrectButton, to: .systemRed)
            timeRemainingLabel.text = "Incorrect"
        case .waiting:
            timeRemainingLabel.text = "Time remaining: \(timeRemaining)"
        case .elapsed:
            disableAnswerButtons()
            timeRemainingLabel.text = "Time elapsed"
            animateBackgroundChanged(for: incorrectButton, to: .systemRed)
        }
    }

    @IBAction func correctPressed(sender: UIButton) {
        status = .correct
                
        //Disable buttons with animation
        //Fetch joke
    }
    
    @IBAction func incorrectPressed() {
        status = .incorrect
    }
    
    @IBAction func nextPressed() {
        status = .waiting
        enableAnswerButtons()
        animateBackgroundChanged(for: correctButton, to: .clear)
        animateBackgroundChanged(for: incorrectButton, to: .clear)
    }
    
    private func disableAnswerButtons() {
        correctButton.isEnabled = false
        incorrectButton.isEnabled = false
    }
    
    private func enableAnswerButtons() {
        correctButton.isEnabled = true
        incorrectButton.isEnabled = true
    }
    
    private func animateBackgroundChanged(for view: UIView, to color: UIColor, with flash: UIColor = .white) {
            UIView.animate(withDuration: 0.1) {
                view.backgroundColor = flash
            } completion: { _ in
                UIView.animate(withDuration: 0.4, delay: 0.5) {
                    view.backgroundColor = color
                }
            }

    }
}
