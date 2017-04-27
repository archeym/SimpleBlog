//
//  ViewController.swift
//  SimpleBlog
//
//  Created by Arkadijs Makarenko on 27/04/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var blogs : [Blog] = []
    
    @IBAction func deleteAllButtonClicked(_ sender: Any) {
        for blog in blogs {
            print("Deleting ID: \(blog.blogID)")
            BlogAPI.deleteAllBlogs(with: blog.blogID)
            sleep(1)
        }
        blogs = []
        tableView.reloadData()
    }
    
    @IBAction func addButtonClick(_ sender: Any) {
        goToDetailVC(blog: Blog())
    }
    
    @IBOutlet weak var tableView: UITableView!{
    didSet{
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BlogCell.cellNib, forCellReuseIdentifier: BlogCell.cellIdentifier)
        tableView.estimatedRowHeight = CGFloat(64.0)
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        BlogAPI.getAllBlogs{(blogs,error) in
            if let validError = error{
                print(validError.localizedDescription)
                return
            }
                self.blogs = blogs
                self.tableView.reloadData()
            }
    }
    
    
    func goToDetailVC(blog: Blog){
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "DeatilViewController") as? DeatilViewController
        vc?.currentBlog = blog
        navigationController?.pushViewController(vc!, animated: true)
    }

}//end

extension ViewController: UITableViewDelegate{
    
}


extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BlogCell.cellIdentifier) as? BlogCell else { return UITableViewCell() }
        return configured(blogCell: cell, withBlog: blogs[indexPath.row])
        }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            print("Deleting Blog")
            BlogAPI.deleteAllBlogs(with: blogs[indexPath.row].blogID)
            blogs.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        goToDetailVC(blog: blogs[indexPath.row])
    
    }
    
    
    func configured(blogCell: BlogCell, withBlog blog: Blog) -> BlogCell{
        blogCell.blogTitleLabel.text = blog.title
        blogCell.blogDetailLabel.text = blog.body
        
        return blogCell
        
    }
}






