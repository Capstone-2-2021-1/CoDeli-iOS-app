//
//  LinkModalViewController.swift
//  KlipSDK-Sample
//
//  Created by conan on 2020/09/09.
//  Copyright © 2020 conan. All rights reserved.
//

import UIKit
import KlipSDK

protocol SendReqeustKeyDelegaete {
    func dataReceived(data: String)
}

class LinkModalViewController: UIViewController, UITextFieldDelegate {
    var errorData: ResponseErrorModel?
    var delegate : SendReqeustKeyDelegaete?
    var keyboardShown:Bool = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LinkError" {
            let errorModalViewController = segue.destination as! ErrorModalViewController
            errorModalViewController.errorData = self.errorData
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            if keyboardHeight == 0.0 || keyboardShown == true || self.bappName.isTracking || self.successCallbackURL.isTracking {
                return
            }
            
            self.view.frame.origin.y -= keyboardHeight
            keyboardShown = true
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        if keyboardShown == false {
            return
        }
        
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            self.view.frame.origin.y += keyboardHeight
            keyboardShown = false
        }
    }
    
    @IBOutlet var linkModalCancel: UIButton!
    @IBAction func hideLinkModal(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet var bappName: UITextField! {didSet {bappName.delegate = self}}
    @IBOutlet weak var successCallbackURL: UITextField! {didSet {successCallbackURL.delegate = self}}
    @IBOutlet weak var failCallbackURL: UITextField! {didSet {failCallbackURL.delegate = self}}
    
    @IBAction func prepareLink(_ sender: Any) {
        if bappName.text?.isEmpty == false {
            let authRequest: AuthRequest = AuthRequest()
            let bappCallbackLink: BAppDeepLinkCB?
            if(successCallbackURL.text?.isEmpty == false || failCallbackURL.text?.isEmpty == false) {
                bappCallbackLink = BAppDeepLinkCB(successURL: successCallbackURL.text!, failURL: failCallbackURL.text!)
            } else {
                bappCallbackLink = nil
            }
            
            let bappInfo: BAppInfo = BAppInfo(name : bappName.text!, callback: bappCallbackLink)
            KlipSDK.shared.prepare(request: authRequest, bappInfo: bappInfo) { result in
                switch result {
                case .success(let response):
                    print(response)
                    DispatchQueue.main.async {
                        self.delegate?.dataReceived(data: response.requestKey)
                    }
                    
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                case .failure(let error):
                    print(error)
                    self.errorData = error
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "LinkError", sender: self)
                    }
                }
            }
        }
    }
}
