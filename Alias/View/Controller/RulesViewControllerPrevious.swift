//
//  RulesViewControllerPrevious.swift
//  Alias
//
//  Created by Maxim Vagin on 02.05.2022.
//

import UIKit

class RulesViewControllerPrevious: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func backButton(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
