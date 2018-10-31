
//
//  MasterViewController.swift
//  SearchUseCode
//
//  Created by Trần Đức Anh on 10/24/18.
//  Copyright © 2018 Trần Đức Anh. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    @IBOutlet weak var detailTextField: UITextField!
    
    var dataDetail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if detailTextField != nil {
            detailTextField.text = dataDetail
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        dataDetail = detailTextField.text
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
