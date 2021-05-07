//
//  ContractExecutionModalViewController.swift
//  KlipSDK-Sample
//
//  Created by conan on 2020/09/09.
//  Copyright © 2020 conan. All rights reserved.
//

import UIKit
import KlipSDK

class ContractExecutionModalViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var errorData: ResponseErrorModel?
    var delegate : SendReqeustKeyDelegaete?
    var keyboardShown:Bool = false
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContractExecutionError" {
            let errorModalViewController = segue.destination as! ErrorModalViewController
            errorModalViewController.errorData = self.errorData
        }
    }
    
    override func viewDidLoad() {
        self.abi.layer.borderWidth = 0.5
        self.abi.layer.cornerRadius = 5
        self.abi.layer.borderColor = UIColor.gray.cgColor
        self.params.layer.borderWidth = 0.5
        self.params.layer.cornerRadius = 5
        self.params.layer.borderColor = UIColor.gray.cgColor
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            if keyboardHeight == 0.0 || keyboardShown == true || self.toContractAddress.isTracking || self.value.isTracking || self.abi.isTracking {
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBOutlet weak var contractExecutionCancel: UIButton!
    @IBAction func hideContractExecutionModal(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet weak var toContractAddress: UITextField! {didSet {toContractAddress.delegate = self}}
    @IBOutlet weak var value: UITextField! {didSet {value.delegate = self}}
    @IBOutlet weak var abi: UITextView! {didSet {abi.delegate = self}}
    @IBOutlet weak var params: UITextView! {didSet {params.delegate = self}}
    @IBOutlet weak var fromAddress: UITextField! {didSet {fromAddress.delegate = self}}
    @IBOutlet weak var bappName: UITextField! {didSet {bappName.delegate = self}}
    @IBOutlet weak var successCallbackURL: UITextField! {didSet {successCallbackURL.delegate = self}}
    @IBOutlet weak var failCallbackURL: UITextField! {didSet {failCallbackURL.delegate = self}}
    @IBAction func prepareContractExecution(_ sender: Any) {
        if (bappName.text?.isEmpty == false && toContractAddress.text?.isEmpty == false &&
            abi.text?.isEmpty == false && params.text?.isEmpty == false && value.text?.isEmpty == false) {
            let contractTxRequest: ContractTxRequest = ContractTxRequest(to: toContractAddress.text!, value: value.text!, abi: abi.text!, params: params.text!, from: fromAddress.text!)
            let bappCallbackLink: BAppDeepLinkCB?
            if(successCallbackURL.text?.isEmpty == false || failCallbackURL.text?.isEmpty == false) {
                bappCallbackLink = BAppDeepLinkCB(successURL: successCallbackURL.text!, failURL: failCallbackURL.text!)
            } else {
                bappCallbackLink = nil
            }
            let bappInfo: BAppInfo = BAppInfo(name : bappName.text!, callback: bappCallbackLink)
            KlipSDK.shared.prepare(request: contractTxRequest, bappInfo: bappInfo) { result in
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
                        self.performSegue(withIdentifier: "ContractExecutionError", sender: self)
                    }
                }
            }
        }
    }
}
