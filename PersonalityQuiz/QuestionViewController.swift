//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by love on 10/22/17.
//  Copyright © 2017 love. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    let questions: [Question] = [
        Question(text: "Which food do you like the most?",
                 type: .single,
                 answers:[Answer(text: "Steak", type: .dog),
                          Answer(text: "Fish", type: .cat),
                          Answer(text: "Carrots", type: .rabbit),
                          Answer(text: "Corn", type: .turtle)]),
        Question(text: "Which activities do you enjoy?",
                 type: .multiple,
                 answers:[Answer(text: "Eating", type: .dog),
                          Answer(text: "Sleeping", type: .cat),
                          Answer(text: "Cuddling", type: .rabbit),
                          Answer(text: "Swimming", type: .turtle)]),
        Question(text: "How much do enjoy car rides?",
                 type: .ranged,
                 answers:[Answer(text: "I love them", type: .dog),
                          Answer(text: "I dislike them", type: .cat),
                          Answer(text: "I get a little nervous", type: .rabbit),
                          Answer(text: "I barely notice them", type: .turtle)])
    ]
    
    var answerChosen: [Answer] = []
    
    var questionIndex = 0

    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var firstAnswerSingleButton: UIButton!
    @IBOutlet weak var secondAnswerSingleButton: UIButton!
    @IBOutlet weak var thirdAnswerSingleButton: UIButton!
    @IBOutlet weak var forthAnswerSingleButton: UIButton!
    
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var firstAnswerMultipleLabel: UILabel!
    @IBOutlet weak var secondAnswerMultipleLabel: UILabel!
    @IBOutlet weak var thirdAnswerMultipleLabel: UILabel!
    @IBOutlet weak var forthAnswerMultipleLabel: UILabel!
    
    @IBOutlet weak var firstAnswerMultipleSwitchView: UISwitch!
    @IBOutlet weak var secondAnswerMultipleSwitchView: UISwitch!
    @IBOutlet weak var thirdAnswerMultipleSwitchView: UISwitch!
    @IBOutlet weak var forthAnswerMultipleSwitchView: UISwitch!
    
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var firstAnswerRangedLabel: UILabel!
    @IBOutlet weak var secondAnswerRangedLabel: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionProgressView: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            guard let resultViewController = segue.destination as? ResultViewController else{
                print("ResultViewController is nil")
                return
            }
            
            resultViewController.responses = answerChosen
        }
    }
    
    func updateUI(){
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let progressValue = Float(questionIndex + 1) / Float(questions.count)
        questionProgressView.setProgress(progressValue, animated: true)
        questionLabel.text = currentQuestion.text
        
        
        
        switch currentQuestion.type {
            case .single:
                updateSingleAnswers(using: currentAnswers)
            case .multiple:
                updateMultipleAnswers(using: currentAnswers)
            case .ranged:
                updateRangedAnswers(using: currentAnswers)
        }
    }
    
    func updateSingleAnswers(using: [Answer]){
        singleStackView.isHidden = false
        firstAnswerSingleButton.setTitle(using[0].text, for: .normal)
        secondAnswerSingleButton.setTitle(using[1].text, for: .normal)
        thirdAnswerSingleButton.setTitle(using[2].text, for: .normal)
        forthAnswerSingleButton.setTitle(using[3].text, for: .normal)
    }
    
    func updateMultipleAnswers(using: [Answer]){
        multipleStackView.isHidden = false
        firstAnswerMultipleSwitchView.isOn = false
        secondAnswerMultipleSwitchView.isOn = false
        thirdAnswerMultipleSwitchView.isOn = false
        forthAnswerMultipleSwitchView.isOn = false
        firstAnswerMultipleLabel.text = using[0].text
        secondAnswerMultipleLabel.text = using[1].text
        thirdAnswerMultipleLabel.text = using[2].text
        forthAnswerMultipleLabel.text = using[3].text
    }
    
    func updateRangedAnswers(using: [Answer]){
        print("in update ranged answers")
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: true)
        firstAnswerRangedLabel.text = using.first?.text
        secondAnswerRangedLabel.text = using.last?.text
    }
    @IBAction func singleAnswerButtonTapped(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
            case firstAnswerSingleButton:
                answerChosen.append(currentAnswers[0])
            case secondAnswerSingleButton:
                answerChosen.append(currentAnswers[1])
            case thirdAnswerSingleButton:
                answerChosen.append(currentAnswers[2])
            case forthAnswerSingleButton:
                answerChosen.append(currentAnswers[3])
            default:
                break
        }
        
        nextQuestion()
    }
    @IBAction func multipleAnswerButtonTapped() {
        let currentAnswers = questions[questionIndex].answers
        
        if firstAnswerMultipleSwitchView.isOn {
            answerChosen.append(currentAnswers[0])
        }
        if secondAnswerMultipleSwitchView.isOn {
            answerChosen.append(currentAnswers[1])
        }
        if thirdAnswerMultipleSwitchView.isOn {
            answerChosen.append(currentAnswers[2])
        }
        if forthAnswerMultipleSwitchView.isOn {
            answerChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    @IBAction func rangedAnswerButtonTapped() {
        let currentAnswers = questions[questionIndex].answers
        
        switch rangedSlider.value {
        case 0...0.25:
            answerChosen.append(currentAnswers[0])
        case 0.26...0.5:
            answerChosen.append(currentAnswers[1])
        case 0.51...0.75:
            answerChosen.append(currentAnswers[2])
        case 0.75...1.0:
            answerChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }
    
    
    
    func nextQuestion(){
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        }
        else{
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
}
