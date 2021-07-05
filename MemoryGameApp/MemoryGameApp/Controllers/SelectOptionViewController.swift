//
//  SelectOptionViewController.swift
//  MemoryGameApp
//
//  Created by apple on 7/3/21.
//

import UIKit


class SelectOptionViewController: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtfName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtfName.delegate = self

      
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.lblName.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.txtfName.endEditing(true)
        return false
    }
    
    
    @IBAction func actionPlay(_ sender: Any) {
        
        if(self.txtfName.text == ""){
            self.lblName.isHidden = false
        }
        else{
            self.lblName.isHidden = true
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            vc.playerName = self.txtfName.text ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
      
    }
    
   
    
}
