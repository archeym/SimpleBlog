//
//  DeatilViewController.swift
//  SimpleBlog
//
//  Created by Arkadijs Makarenko on 27/04/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import UIKit

class DeatilViewController: UIViewController {
    
    var currentBlog : Blog!
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        
        currentBlog.title = textField.text!
        currentBlog.body = textView.text!
        
        if currentBlog.blogID == 1001 {
            BlogAPI.createABlog(with: currentBlog) { (blog, error) in
                if let validError = error {
                    print(validError.localizedDescription)
                    return
                }
            }
        } else {
            BlogAPI.updateABlog(with: currentBlog) { (blog, error) in
                if let validError = error {
                    print(validError.localizedDescription)
                    return
                }
            }
        }
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = currentBlog.title
        textView.text = currentBlog.body
        
    }
}
