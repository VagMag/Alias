//
//  ChoiceViewController.swift
//  Alias
//
//  Created by Maxim Vagin on 02.05.2022.
//

import UIKit

class ChoiceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? GameViewController else { return }
        vc.topic = segue.identifier ?? "english_words_nouns"
    }

}
