//
//  gameViewController.swift
//  codeBREAKER
//
//  Created by user145843 on 9/20/18.
//  Copyright © 2018 T3Tech. All rights reserved.
//

import UIKit
import Firebase
class gameViewController: UIViewController {
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tryField1: UITextField!
    @IBOutlet weak var tryField2: UITextField!
    @IBOutlet weak var tryField3: UITextField!
    @IBOutlet weak var tryField4: UITextField!
    @IBOutlet weak var tryField5: UITextField!
    @IBOutlet weak var tryField6: UITextField!
    @IBOutlet weak var tryField7: UITextField!
    @IBOutlet weak var tryField8: UITextField!
    @IBOutlet weak var tryField9: UITextField!
    @IBOutlet weak var tryField10: UITextField!
    @IBOutlet weak var result1: UILabel!
    @IBOutlet weak var result2: UILabel!
    @IBOutlet weak var result3: UILabel!
    @IBOutlet weak var result4: UILabel!
    @IBOutlet weak var result5: UILabel!
    @IBOutlet weak var result6: UILabel!
    @IBOutlet weak var result7: UILabel!
    @IBOutlet weak var result8: UILabel!
    @IBOutlet weak var result9: UILabel!
    @IBOutlet weak var result10: UILabel!
    @IBOutlet weak var win1: UILabel!
    @IBOutlet weak var win2: UILabel!
    @IBOutlet weak var win3: UILabel!
    @IBOutlet weak var win4: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var objectiveField: UITextField!
    
    
    
    
    var hasWon: Bool = false
    var score: Int = 0
    let bDot: String = "•"
    let wDot: String = "◦"
    var tryLabelArray: [(UITextField,UILabel)] = []
    var trys: Int = 2
    var target: Array = [0]
    var guess: Array = [0,0,0,0]
    var username = ""
    var bestScore = 0
    var bannerView: GADBannerView!
    var isTyping = false
    var lastRec: CGRect = CGRect()
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tryLabelArray = [(tryField1,result1),(tryField2,result2),(tryField3,result3),(tryField4,result4),(tryField5,result5),(tryField6,result6),(tryField7,result7),(tryField8,result8),(tryField9,result9),(tryField10,result10)]
        
        
        errorLabel.text = ""
        var temp = [Int(arc4random_uniform(6))]
        while temp.count < 4 {
            let ins = Int(arc4random_uniform(6))
            if !temp.contains(ins){
                temp.append(ins)
            }
        }
        print(temp)
        target = temp
        scoreLabel.text = "Score: "+String(score)
        
      /**  NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
        **/
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-7349651961210984/8722151958"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.isHidden = false
        
    
    
    }
    @objc func keyboardNotification(notification:NSNotification)
    {
        //print(notification)
        //  notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double == 0.25{
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
        
        
       if !isTyping{
            lastRec = tryLabelArray[trys-2].0.frame
            let y = keyboardHeight + tryLabelArray[trys-2].0.frame.height
            let x = UIScreen.main.bounds.midX
            tryLabelArray[trys-2].0.center = CGPoint(x:x,y:y)
            isTyping = true
            //print(true)
            
        }
        //else{
            //tryLabelArray[trys-2].0.frame = lastRec
            //isTyping = false
            ////print(false)
          //  }
        }
       // }
    }

    func setArrow()
    {
        self.arrowImage.isHidden = false
        let xPos: CGFloat = self.tryField1.center.x - (self.tryField1.frame.width/2)
        self.arrowImage.center = CGPoint(x:xPos/2,y:tryLabelArray[trys-2].0.center.y)
        //print(self.arrowImage.center)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get a reference to the second view controller
        let button = sender as! UIButton
        if button.currentTitle == "Continue"{
        let secondViewController = segue.destination as! winViewController
        
        // set a variable in the second view controller with the String to pass
        secondViewController.receivedString = scoreLabel.text!
        secondViewController.bestScore = self.bestScore
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
            }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func guessButton(_ sender: Any) {
        self.view.endEditing(true)
        var inputLabel:UITextField = tryLabelArray[trys-2].0
        errorLabel.text = ""
        //print("#######",inputLabel.text,"#######")
        if inputLabel.text == Optional("") || inputLabel.text?.count != 4 && Int(inputLabel.text!) != nil{
            errorLabel.text = "Must have 4 numbers to guess"
            
        }
        else{
            if let inputLabelText = inputLabel.text{
                ////print(inputLabelText)
                var inc = 0
                for i in inputLabelText{
                    if let iI = Int(String(i)){
                        guess[inc] = iI
                        inc+=1
                        }
                }
                }
            
        closeAll()
        if trys != 11{
                tryLabelArray[trys-1].0.isEnabled=true
        }

        var result = guessFunc(guess: guess)
        var resultv2 = ""
        for letter in result {
            if letter == "B"{
                resultv2 += bDot
            }
            else if letter == "W" {
                resultv2 += wDot
            }
        }
        result = resultv2
        trys += 1
        
        var strGuess = ""
        for items in guess{
            strGuess += String(items)
        }
        if result == "••••"{
            win()
        }
        else if trys == 12{
            print("lose 223 GVC")
            lose()
            
            }
        else{
            setArrow()
            }
        tryLabelArray[trys-3].0.text = strGuess
        tryLabelArray[trys-3].1.text = result
        }
        

        }
    func lose(){
        closeAll()
        tryLabel.text = "Game Over"
        win1.text = String(target[0])
        win2.text = String(target[1])
        win3.text = String(target[2])
        win4.text = String(target[3])
        guessButton.isEnabled = false
        print(bestScore, score,"loseMeth 244 GVC")
        if bestScore < score{
            var rootRef = FIRDatabase.database().reference().child("users")
            rootRef.child(((FIRAuth.auth()?.currentUser?.uid)!)).child("Score").setValue(score)
            bestScore = score
        }
    }
    func toList(str: String)->Array<String>{
        var curLis: Array<String> = []
        for i in str{
            curLis.append(String(i))
            
        }
        return curLis
    }
    @IBAction func contiuneGame(_ sender: Any) {
        
    }
    func Count(item: Int ,arr:Array<Int> ) -> Int {
        var count = 0
        for i in arr{
            if i == item{
                count += 1
            }
            
        }
        return count
    }
    
    func get(str: String,index: Int)->String {
        var count = 0
        for i in str{
            if count == index{
                
                return String(i)
            }
            else{
                count+=1}
            
        }
        return ""
    }
    func Subtract(res: String)-> String{
        var boole: Bool = true
        var count = 0
        var i = get(str: res,index:0)
        if  res.contains("W") {
            while i != "W" && count < 4{
                count+=1
                i = get(str:res,index: count)
            }
        }
        
        var res1 = String(res.prefix(count) + res.suffix(count+1))
        if count == 0{
            res1 = res
        }
        
        return res1
    }
    func guessFunc(guess: Array<Int>)-> String{
        ////print(guess)
        ////print(target)
        var res: String = ""
        var alreadyC: Array<Int> = []
        var index = 0
        for item in guess{
            if target.contains(item){
                if alreadyC.contains(item){
                    if guess[index] == target[index]{
                        res += "B"
                        res = Subtract(res:res)
                        
                    }
                }
                else{
                    var numItem = Count(item: item,arr: target)
                    if guess[index] == target[index]{
                        res += "B"
                        
                        alreadyC.append(item)
                        if numItem > 1 {
                            for i in 1...numItem-1{
                                res+="W"
                                
                            }
                        }
                    }
                    else{
                        if numItem > 1 {
                            for i in 1...numItem{
                                res+="W"
                            }
                        }
                        else {
                            res+="W"
                        }
                        alreadyC.append(item)
                    }
                }
                
            }
            index += 1
            
        }
       
        tryLabel.text = "Try: "+String(trys)
        return res

            
        }
    func closeAll(){
        for item in tryLabelArray{
            item.0.isEnabled = false
        }
    }
override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func gameOver() {
        
}
    func win()
    {
        for items in tryLabelArray{
            items.0.isEnabled = false
            items.1.isEnabled = false
            continueButton.isHidden = false
            
        }
        guessButton.isEnabled = false

        tryLabel.text = "You Won!"
        win1.text = String(target[0])
        win2.text = String(target[1])
        win3.text = String(target[2])
        win4.text = String(target[3])
        score = 100 - ((trys-2)*10) + score
        scoreLabel.text = "Score: " + String(score)
        //let game = gameViewController()
        //print(FIRAuth.auth()?.currentUser?.uid)
        if bestScore < score && FIRAuth.auth()?.currentUser?.uid != nil {
            var rootRef = FIRDatabase.database().reference().child("users")
            rootRef.child(((FIRAuth.auth()?.currentUser?.uid)!)).child("Score").setValue(score)
            bestScore = score
        }
        
        
        
    }
    

}
