//
//  SendCardModalViewController.swift
//  KlipSDK-Sample
//
//  Created by conan on 2020/09/09.
//  Copyright © 2020 conan. All rights reserved.
//

import UIKit
import KlipSDK

class SendCardModalViewController: UIViewController, UITextFieldDelegate {
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
        if segue.identifier == "SendCardError" {
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
            
            if keyboardHeight == 0.0 || keyboardShown == true || self.toAddress.isTracking || self.contractAddress.isTracking || self.cardId.isTracking || self.fromAddress.isTracking {
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
    
    @IBOutlet weak var sendCardCancel: UIButton!
    @IBAction func hideSendCardModal(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBOutlet weak var contractAddress: UITextField! {didSet {contractAddress.delegate = self}}
    @IBOutlet weak var toAddress: UITextField! {didSet {toAddress.delegate = self}}
    @IBOutlet weak var cardId: UITextField! {didSet {cardId.delegate = self}}
    @IBOutlet weak var fromAddress: UITextField! {didSet {fromAddress.delegate = self}}
    @IBOutlet weak var bappName: UITextField! {didSet {bappName.delegate = self}}
    @IBOutlet weak var successCallbackURL: UITextField! {didSet {successCallbackURL.delegate = self}}
    @IBOutlet weak var failCallbackURL: UITextField! {didSet {failCallbackURL.delegate = self}}
    
    @IBAction func prepareSendCard(_ sender: Any) {
        if (bappName.text?.isEmpty == false && contractAddress.text?.isEmpty == false &&
            toAddress.text?.isEmpty == false && cardId.text?.isEmpty == false && cardId.text != "0") {
            let cardTxRequest: CardTxRequest = CardTxRequest(to: toAddress.text!, contract: contractAddress.text!, cardId: cardId.text!, from: fromAddress.text!)
            let bappCallbackLink: BAppDeepLinkCB?
            if(successCallbackURL.text?.isEmpty == false || failCallbackURL.text?.isEmpty == false) {
                bappCallbackLink = BAppDeepLinkCB(successURL: successCallbackURL.text!, failURL: failCallbackURL.text!)
            } else {
                bappCallbackLink = nil
            }
            let bappInfo: BAppInfo = BAppInfo(name : bappName.text!, callback: bappCallbackLink)
            KlipSDK.shared.prepare(request: cardTxRequest, bappInfo: bappInfo) { result in
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
                    self.errorData = error
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "SendCardError", sender: self)
                    }
                }
            }
        }
    }
}
