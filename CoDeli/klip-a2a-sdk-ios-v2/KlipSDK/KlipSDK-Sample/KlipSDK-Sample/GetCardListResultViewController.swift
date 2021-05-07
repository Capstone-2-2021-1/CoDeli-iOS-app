//
//  GetCardListResultViewController.swift
//  KlipSDK-Sample
//
//  Created by conan on 2020/09/10.
//  Copyright © 2020 conan. All rights reserved.
//

import UIKit
import KlipSDK

class GetCardListResultViewController: UIViewController {
    var response: CardListResponse?
    
    @IBOutlet weak var cardName: UITextField!
    @IBOutlet weak var symbolImage: UITextField!
    @IBOutlet weak var nextCursor: UITextField!
    @IBOutlet weak var cards: UITextView!
    @IBAction func hideCardListResultModal(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if response != nil {
            cardName.text = response?.name
            symbolImage.text = response?.symbolImg
            do {
                try toString()
            } catch {
                print(error)
            }
        }
    }
    
    func toString() throws -> Void {
        do {
            var cardData = try JSONEncoder().encode(response!.cards)
            cards.text = String(decoding: cardData, as: UTF8.self)
        } catch {
            print(error)
        }
    }
    
    
    
}
