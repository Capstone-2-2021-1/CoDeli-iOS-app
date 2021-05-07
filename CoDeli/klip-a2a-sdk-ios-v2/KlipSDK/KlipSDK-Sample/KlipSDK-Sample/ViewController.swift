//
//  ViewController.swift
//  KlipSDK-Sample
//
//  Created by conan on 2020/09/08.
//  Copyright © 2020 conan. All rights reserved.
//

import UIKit
import KlipSDK

class ViewController: UIViewController, SendReqeustKeyDelegaete {
    @IBOutlet weak var currentRequestKeyLabel: UILabel!
    var currentResult: KlipTxResponse?
    var errorData: ResponseErrorModel?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowLinkModal" {
            let linkModal = segue.destination as! LinkModalViewController
            linkModal.delegate = self
        }
        
        if segue.identifier == "ShowSendKlayModal" {
            let sendKlayModal = segue.destination as! SendKlayModalViewController
            sendKlayModal.delegate = self
        }
        
        if segue.identifier == "ShowSendTokenModal" {
            let sendTokenModal = segue.destination as! SendTokenModalViewController
            sendTokenModal.delegate = self
        }
        
        if segue.identifier == "ShowSendCardModal" {
            let sendCardModal = segue.destination as! SendCardModalViewController
            sendCardModal.delegate = self
        }
        
        if segue.identifier == "ShowContractExecutionModal" {
            let contractExecutionModalViewController = segue.destination as! ContractExecutionModalViewController
            contractExecutionModalViewController.delegate = self
        }
        
        if segue.identifier == "ShowGetResultModal" {
            let getResultModalViewController = segue.destination as! GetResultModalViewController
            getResultModalViewController.response = self.currentResult
        }
        
        if segue.identifier == "GetResultError" {
            let errorModalViewController = segue.destination as! ErrorModalViewController
            errorModalViewController.errorData = self.errorData
        }
    }
    
    @IBAction func requestButton(_ sender: Any) {
        print(currentRequestKeyLabel.text)
        if currentRequestKeyLabel.text?.isEmpty == false {
            KlipSDK.shared.request(requestKey: currentRequestKeyLabel.text!)
        }
    }
    
    @IBAction func getResult(_ sender: Any) {
        if currentRequestKeyLabel.text?.isEmpty == false {
            KlipSDK.shared.getResult(requestKey: currentRequestKeyLabel.text!) { result in
                switch result {
                case .success(let response):
                    print(response)
                    self.currentResult = response
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "ShowGetResultModal", sender: self)
                    }
                    
                case .failure(let error):
                    print(error)
                    self.errorData = error
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "GetResultError", sender: self)
                    }
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func dataReceived(data: String) {
        currentRequestKeyLabel.text = data
    }
}




