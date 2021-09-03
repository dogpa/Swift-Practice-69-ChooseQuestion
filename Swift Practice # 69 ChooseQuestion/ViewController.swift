//
//  ViewController.swift
//  Swift Practice # 69 ChooseQuestion
//
//  Created by Dogpa's MBAir M1 on 2021/9/3.
//

import UIKit

class ViewController: UIViewController {
    
  
    @IBOutlet weak var timesForPlayLabel: UILabel!      //第幾道題目
    @IBOutlet weak var randomOneLabel: UILabel!         //乘數1
    @IBOutlet weak var randomTwoLabel: UILabel!         //乘數2
    @IBOutlet var optionButtonArray: [UIButton]!        //3個button的outlet collection
    @IBOutlet weak var rightResult: UILabel!            //答對的emoji
    @IBOutlet weak var wrongResult: UILabel!            //答錯的emoji
    @IBOutlet weak var timesForRightLabel: UILabel!     //答對幾題的label
    
    var index = 1                       //第幾道題目
    var timesForRightQS = 0             //猜對了幾題
    var randomOne = 0                   //隨機承數1
    var randomTwo = 0                   //隨機承數2
    var oneMultTwo = 0                  //隨機承數1 隨機承數2兩者相乘
    var answerChooseArray: [Int] = []   //數字array用於指派button的title
    var answerChooseOne = 0             //第一個隨機數字
    var answerChooseTwo = 0             //第二個隨機數字
    var answerChooseThree = 0           //第三個數字存放oneMultTwo
    
    //背景顏色Array
    var buttonColor : [UIColor] = [.black, .blue, .brown , .link, .lightGray, .orange, .purple, .systemGreen, .systemPink, .lightGray, .systemRed, .cyan, .darkGray, .systemYellow, .yellow, .systemTeal ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeButtonColor()                         //button換色
        randomQuestion()                            //產生隨機題目
        timesForPlayLabel.text = "第 \(index) 題"    //顯示第幾道題目
        timesForRightLabel.isHidden = true          //隱藏猜對題數label
        showOrNotResult(right: true, wrong: true)   //隱藏對錯emoji
        
    }

    //Button重新設定背景顏色
    func changeButtonColor () {
        buttonColor.shuffle()
        for i in 0...2 {
            optionButtonArray[i].backgroundColor = buttonColor[i]
        }
    }
    
    //設定對錯的emoji顯示狀況，依照實際需求去改變bool值
    func showOrNotResult (right:Bool, wrong:Bool){
        rightResult.isHidden = right
        wrongResult.isHidden = wrong
    }
    
    //猜對執行的func
    func chooseRightAnswer () {
        timesForRightQS += 1
        showOrNotResult(right: false, wrong: true)

    }
    
    //猜錯的func
    func chooseWrongAnswer () {
        timesForRightQS += 0
        showOrNotResult(right: true, wrong: false)
    }

    //產生隨機題目
    func randomQuestion () {
        answerChooseOne = Int.random(in: 1...99)    //answerChooseOne 隨機賦值
        answerChooseTwo = Int.random(in: 1...99)    //answerChooseTwo 隨機賦值
        randomOne = Int.random(in: 1...9)           //randomOne隨機賦值
        randomTwo = Int.random(in: 1...9)           //randomTwo隨機賦值
        oneMultTwo = randomOne * randomTwo          //randomOne與randomTwo 相乘後指派給oneMultTwo
        answerChooseThree = oneMultTwo              //指派oneMultTwo給answerChooseThree
        
                                                    //將三個數字放進answerChooseArray中
        answerChooseArray = [answerChooseOne, answerChooseTwo, answerChooseThree]
        answerChooseArray.shuffle()                 //變更answerChooseArray值得順位
        
        for i in 0...2 {                            //將 answerChooseArray值設定進入button的title中
            optionButtonArray[i].setTitle(String(answerChooseArray[i]), for: .normal)
        }
        changeButtonColor()                         //隨機產生button背景顏色
        randomOneLabel.text = String(randomOne)     //指派數字給randomOneLabel
        randomTwoLabel.text = String(randomTwo)     //指派數字給randomTwoLabel
    }
    
    //透過func判斷猜對次數 給不同的顯示
    func checkTimesForRightAns() {
        if timesForRightQS < 3 {
            timesForRightLabel.text = "答對 \(timesForRightQS) 題 \n要多練習喔"
            timesForRightLabel.textColor = .black
        }else if timesForRightQS > 2 && timesForRightQS <= 6 {
            timesForRightLabel.text = "答對 \(timesForRightQS) 題 \n學習狀況不錯"
            timesForRightLabel.textColor = .blue
        }else if timesForRightQS > 6 && timesForRightQS <= 9 {
            timesForRightLabel.text = "答對 \(timesForRightQS) 題 \n數學有很大進步"
            timesForRightLabel.textColor = .blue
        }else if timesForRightQS == 10 {
            timesForRightLabel.text = "答對 \(timesForRightQS) 題 \n全對數學小神童"
            timesForRightLabel.textColor = .red
        }
    }
    
    //按下Button的Action
    @IBAction func startPlay(_ sender: UIButton) {

            index += 1
            timesForPlayLabel.text = "第 \(index) 題"
            showOrNotResult(right: true, wrong: true)
            
            //判斷所選答案是否正確進行不同的func
            if sender.currentTitle == String(answerChooseThree) {
                chooseRightAnswer()
            }else{
                chooseWrongAnswer()
            }
            checkTimesForRightAns()
            randomQuestion()
            //答對十題之後顯示結果
        if index == 11 {
            index = 10
            timesForPlayLabel.text = "第 \(index) 題"
            let alertController = UIAlertController(title: "恭喜玩完" , message: "一起看猜對幾題吧", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "返回", style: .default)
                            alertController.addAction(okAction)
                            present(alertController, animated: true, completion: nil)
            timesForRightLabel.isHidden = false
            showOrNotResult(right: true, wrong: true)
        }

    }
    
  
    
    //重新玩一次的Button
    @IBAction func replay(_ sender: UIButton) {
        index = 1
        timesForRightQS = 0
        randomOne = 0
        randomTwo = 0
        oneMultTwo = 0
        answerChooseArray = []
        answerChooseOne = 0
        answerChooseTwo = 0
        answerChooseThree = 0
        timesForPlayLabel.text = "第 \(index) 題"
        timesForRightLabel.isHidden = true
        randomQuestion()
        
    }
    
}
