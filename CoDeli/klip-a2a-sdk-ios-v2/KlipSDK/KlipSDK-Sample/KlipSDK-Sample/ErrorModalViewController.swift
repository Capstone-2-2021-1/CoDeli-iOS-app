//
//  ErrorModalViewController.swift
//  KlipSDK-Sample
//
//  Created by conan on 2020/10/14.
//  Copyright © 2020 Ground1 Corp. All rights reserved.
//

import Foundation
import UIKit
import KlipSDK

class ErrorModalViewController: UIViewController {
    var errorData: ResponseErrorModel?
    @IBOutlet weak var httpStatusCode: UITextField!
    @IBOutlet weak var errorCode: UITextField!
    @IBOutlet weak var errorMsg: UITextView!
    
    
    
    @IBAction func hideCardListResultModal(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.errorMsg.layer.borderWidth = 0.5
        self.errorMsg.layer.cornerRadius = 5
        self.errorMsg.layer.borderColor = UIColor.gray.cgColor
        
        if errorData != nil {
            httpStatusCode.text = String(errorData!.httpStatus)
            errorCode.text = String(errorData!.errorCode)
            errorMsg.text = errorData?.errorMsg
        }
    }
}
