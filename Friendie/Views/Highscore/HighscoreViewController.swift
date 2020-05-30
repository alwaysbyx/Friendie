//
//  HighscoreViewController.swift
//  Friendie
//
//  Created by BB on 2020/5/25.
//  Copyright © 2020 Com. All rights reserved.
//

import UIKit

class HighscoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        writeScore()
        // Do any additional setup after loading the view.
    }
    /*
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        writeScore()
    }
 */
    
    @IBOutlet weak var textLb: UILabel!
    
    @IBAction func backtohome(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func writeScore() {
        let score = UserDefaults.standard.integer(forKey: "score")
        if score == 0 {
            textLb.text = "Sorry, it seems that you haven't played yet!"
        }else {
            textLb.text = "Haha~ Your best score is " + String(score) + "!"
        }
        
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
