//
//  DeatilViewController.swift
//  SimpleBlog
//
//  Created by Arkadijs Makarenko on 27/04/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var currentBlog : Blog?
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        if currentBlog == nil{
            newBlog()
        }else{
            updateBlog()
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    func updateBlog(){
        let dictionary : [String: Any] = ["blog" : convertToDictionary()]
        
        BlogAPI.updateABlog(with: Int((currentBlog?.blogID)!)!, dictionary: dictionary)
    }
    func newBlog(){
        let dictionary : [String: Any] = ["blog" : convertToDictionary()]
        BlogAPI.createABlog(dictionary: dictionary)
    }
    func convertToDictionary() -> [ String:String]{
        var dict : [String:String]=[:]
        guard let title = textField.text,
            let body = textView.text else {
                return [:]
        }
        dict.updateValue(title, forKey: "title")
        dict["body"] = body
        return dict
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = currentBlog?.title
        textView.text = currentBlog?.body
        changeButtonTitle()
    }
    func changeButtonTitle(){
        if currentBlog == nil{
            button.setTitle("Save", for: .normal)
        }else{
            button.setTitle("Update", for: .normal)
        }
    }
    
}
