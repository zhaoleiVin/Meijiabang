//
//  LCYRessetPasswordViewController.swift
//  KickYourAss
//
//  Created by eagle on 15/2/12.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class LCYRessetPasswordViewController: UIViewController {
    
    @IBOutlet private weak var originalPasswordTextField: UITextField!
    @IBOutlet weak var originalPasswordLine: UIImageView!
    
    @IBOutlet private weak var newPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordLine: UIImageView!

    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordLine: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clearRedLines() {
        originalPasswordLine.image = UIImage(named: "textFieldBottomGray")
        newPasswordLine.image = UIImage(named: "textFieldBottomGray")
        confirmPasswordLine.image = UIImage(named: "textFieldBottomGray")
    }

    @IBAction func checkMarkPressed(sender: AnyObject) {
        let oldPass = originalPasswordTextField.text ?? ""
        let newPass = newPasswordTextField.text ?? ""
        let newPass2 = confirmPasswordTextField.text ?? ""
        func checkValid() -> Bool {
            if countElements(oldPass) == 0 {
                alert("请输入原始密码")
                return false
            }
            if countElements(oldPass) < 6 {
                alert("请输入6位以上的原始密码")
                return false
            }
            if countElements(newPass) == 0 {
                alert("请输入新密码")
                return false
            }
            if countElements(newPass) < 6 {
                alert("新密码至少要6位")
                return false
            }
            if newPass != newPass2 {
                alert("两次输入密码不一致")
                return false
            }
            return true
        }
        if checkValid() {
            let parameter = [
                ""
            ]
        }
    }
    
    @IBAction func backgroundTapped(sender: AnyObject) {
        originalPasswordTextField.resignFirstResponder()
        newPasswordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LCYRessetPasswordViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        clearRedLines()
        if textField == originalPasswordTextField {
            originalPasswordLine.image = UIImage(named: "textFieldBottomRed")
        } else if textField == newPasswordTextField {
            newPasswordLine.image = UIImage(named: "textFieldBottomRed")
        } else if textField == confirmPasswordTextField {
            confirmPasswordLine.image = UIImage(named: "textFieldBottomRed")
        }
    }
}
