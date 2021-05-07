//
//  GetCardListModalViewController.swift
//  KlipSDK-Sample
//
//  Created by conan on 2020/09/10.
//  Copyright © 2020 conan. All rights reserved.
//

import UIKit
import KlipSDK
class GetCardListModalViewController: UIViewController, UITextFieldDelegate {
    var errorData: ResponseErrorModel?
    var response: CardListResponse?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBOutlet weak var cancel: UIButton!
    @IBAction func HideGetCardListModal(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBOutlet weak var cardAddress: UITextField! {didSet {cardAddress.delegate = self}}
    @IBOutlet weak var userAddress: UITextField! {didSet {userAddress.delegate = self}}
    @IBOutlet weak var cursor: UITextField! {didSet {cursor.delegate = self}}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowGetCardListResultModal" {
            let getCardListResultModalViewController = segue.destination as! GetCardListResultViewController
            getCardListResultModalViewController.response = self.response
        }
        
        if segue.identifier == "GetCardListError" {
            let errorModalViewController = segue.destination as! ErrorModalViewController
            errorModalViewController.errorData = self.errorData
        }
    }
    
    @IBAction func getCardList(_ sender: Any) {
        if cardAddress.text?.isEmpty == false && userAddress.text?.isEmpty == false {
            KlipSDK.shared.getCardList(cardAddress: cardAddress.text!, userAddress: userAddress.text!, cursor: cursor.text) { result in
                switch result {
                case .success(let response):
                    print(response)
                    self.response = response
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "ShowGetCardListResultModal", sender: self)
                    }
                case .failure(let error):
                    print(error)
                    self.errorData = error
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "GetCardListError", sender: self)
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
