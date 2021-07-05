//
//  ViewController.swift
//  MemoryGameApp
//
//  Created by apple on 7/2/21.
//

import UIKit


class ViewController: UIViewController ,UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblMoves: UILabel!
    var imagesArray = ["i1","i2","i3","i4","i5","i6","i7","i8","i6","i2","i3","i1","i5","i8","i7","i4"]
    var movesCount = 0
    var timer = Timer()
    var totalSeconds : Float = 0.0
    var currentSelectedCell = [Int]()
    var matchCount = 0
    var playerName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        self.imagesArray.shuffle()
        self.collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.endTimer()
    }
    
    @objc func updateTime() {
            self.lblTime.text = timeFormatted(self.totalSeconds)
            self.totalSeconds += 1
    }
    func endTimer() {
        timer.invalidate()
    }
    
    @IBAction func actionBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    func timeFormatted(_ totalSeconds: Float) -> String {
        let seconds: Int = Int(totalSeconds) % 60
        let prodMinutes = Int(totalSeconds) / 60 % 60
        let hours = Int(totalSeconds) / 3600
        if(hours > 0){
            return String(format: "%02d:%02d:%02d",hours, prodMinutes,seconds)
        }
        else{
            return String(format: "%02d:%02d", prodMinutes,seconds)
        }
       
    }
    
    func moveToResultController(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        vc.totalSeconds = self.totalSeconds
        vc.moves = self.movesCount
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func CheckCardAndflipBack(){
        if(self.currentSelectedCell.count == 2){
            let cell1 = self.collectionView.cellForItem(at: IndexPath(item: self.currentSelectedCell[0], section: 0)) as! ImageCollectionViewCell
            let cell2 = self.collectionView.cellForItem(at: IndexPath(item: self.currentSelectedCell[1], section: 0)) as! ImageCollectionViewCell
            
            if(self.imagesArray[self.currentSelectedCell[0]] == self.imagesArray[self.currentSelectedCell[1]]){
                UIView.transition(with: cell1.image, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromRight, animations: { () -> Void in
                    cell1.isUserInteractionEnabled = false
                    cell1.image.isHidden = true
                }, completion: nil)
                UIView.transition(with: cell2.image, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromRight, animations: { () -> Void in
                    cell2.isUserInteractionEnabled = false
                    cell2.image.isHidden = true
                    self.currentSelectedCell.removeAll()
                    self.collectionView.isUserInteractionEnabled = true
                }, completion: nil)
                self.matchCount = self.matchCount + 1
                print(self.matchCount)
                if(self.matchCount == 8){
                    self.moveToResultController()
                }
            }
            else{
                UIView.transition(with: cell1.image, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromRight, animations: { () -> Void in
                    cell1.image.image = UIImage(named: "hide")
                }, completion: nil)
                UIView.transition(with: cell2.image, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromRight, animations: { () -> Void in
                    cell2.image.image = UIImage(named: "hide")
                    self.currentSelectedCell.removeAll()
                    self.collectionView.isUserInteractionEnabled = true
                }, completion: nil)
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.currentSelectedCell.count > 0 && self.currentSelectedCell[0] == indexPath.item{
            return
        }
        
        else{
            let cell = self.collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
            self.movesCount = self.movesCount + 1
            self.lblMoves.text = "\(movesCount)"
            UIView.transition(with: cell.image, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromRight, animations: { () -> Void in
                cell.image.image = UIImage(named: self.imagesArray[indexPath.item])
            }, completion: nil)
            self.currentSelectedCell.append(indexPath.item)
            if(self.currentSelectedCell.count == 2){
                self.collectionView.isUserInteractionEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.CheckCardAndflipBack()
                }
                
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width / 4, height: self.collectionView.bounds.height / 4)
    }
    
    

}

