//
//  GetResultModalViewController.swift
//  KlipSDK-Sample
//
//  Created by conan on 2020/09/10.
//  Copyright © 2020 conan. All rights reserved.
//

import UIKit
import KlipSDK

class GetResultModalViewController: UIViewController {
    var response: KlipTxResponse?
    
    @IBOutlet weak var requestKey: UITextField!
    @IBOutlet weak var status: UITextField!
    @IBOutlet weak var expirationTime: UITextField!
    @IBOutlet weak var klaytnAddress: UITextField!
    @IBOutlet weak var txHash: UITextField!
    @IBOutlet weak var resultStatus: UITextField!
    @IBOutlet weak var txHashLabel: UILabel!
    @IBOutlet weak var resultStatusLabel: UILabel!
    @IBOutlet weak var klaytnAddressLabel: UILabel!
    @IBAction func hideGetResultModal(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (response != nil) {
            txHashLabel.isHidden = true
            resultStatusLabel.isHidden = true
            klaytnAddressLabel.isHidden = true
            txHash.isHidden = true
            resultStatus.isHidden = true
            klaytnAddress.isHidden = true
            
            requestKey.text = response?.requestKey
            status.text = response?.status
            expirationTime.text = String(response!.expirationTime)
            if response!.result != nil {
                if (response!.result?.txHash) != nil {
                    txHashLabel.isHidden = false
                    txHash.isHidden = false
                    txHash.text = response!.result?.txHash
                }
                
                if (response!.result?.status) != nil {
                    resultStatusLabel.isHidden = false
                    resultStatus.isHidden = false
                    resultStatus.text = response!.result?.status
                }
                
                if (response!.result?.klaytnAddress) != nil {
                    klaytnAddressLabel.isHidden = false
                    klaytnAddress.isHidden = false
                    klaytnAddress.text = response!.result?.klaytnAddress
                }
            }
        }
    }
}
