//
//  ViewController.swift
//  Lab4_101023
//
//  Created by user248634 on 10/10/23.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var myActivityInd: UIActivityIndicatorView!
    @IBOutlet weak var myImageView: UIImageView!
    
    lazy var myModel = Model()
    
    var selectedRow:Int=0;
    
    lazy var myKeys = Array(myModel.listOfImages.keys)
    var selectedKey:String = "" {
        didSet{
            myActivityInd.isHidden = false
            myActivityInd.startAnimating()
            
            guard let imgUrlString = myModel.listOfImages[selectedKey] else{
                return
            }
            Service.shared.getImage(urlString: imgUrlString) { data in
                guard let data = data else{
                    return
                }
                
                let img = UIImage(data: data)
                Thread.sleep(forTimeInterval: 2)
                DispatchQueue.main.async {[unowned self] in
                    self.myActivityInd.stopAnimating()
                    self.myImageView.image = img
                    myActivityInd.isHidden = true
                    
                }
            }
        }
    }
    
    
    @IBOutlet weak var myPickerView: UIPickerView!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myModel.listOfImages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //let myKeys = Array(myModel.listOfImages.keys)
        return myKeys[row]
    }
    
 
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        print("Right")
        if(selectedRow==0){
            selectedRow = myKeys.count-1
        }else{
            selectedRow = selectedRow-1
        }
        selectedKey = myKeys[selectedRow]
        myPickerView.selectRow(selectedRow, inComponent: 0, animated: true)
    }
    
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        print("Left")
        if(selectedRow==(myKeys.count-1)){
            selectedRow = 0
        }else{
            selectedRow = selectedRow+1
        }
        selectedKey = myKeys[selectedRow]
        myPickerView.selectRow(selectedRow, inComponent: 0, animated: true)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
        selectedKey = myKeys[row]
    }
    
//    @objc private func didSwipe(gesture:UIGestureRecognizer){
//        guard var currentIndex = myKeys.firstIndex(of: selectedKey) else{
//            return
//        }
//        guard  let swipeGesture = gesture as? UISwipeGestureRecognizer else{return}
//        if(swipeGesture.direction == .right){
//            currentIndex = currentIndex+1
//        }else if(swipeGesture.direction == .left){
//            currentIndex = currentIndex-1
//        }
//
//        selectedKey = myKeys[currentIndex]
//    }
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedKey = myKeys[0]
        myActivityInd.isHidden = true
       // selectedRow = 0;
        
//        let swipeGestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
//
//        swipeGestureRecognizerRight.direction = .right
//
//        myImageView.addGestureRecognizer(swipeGestureRecognizerRight)
//        let swipeGestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
//
//        swipeGestureRecognizerLeft.direction = .left
//        myImageView.addGestureRecognizer(swipeGestureRecognizerLeft)
        
    }
}



