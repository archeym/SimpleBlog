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
    
    @IBAction func addButtonClick(_ sender: Any) {
        let detailController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        navigationController?.pushViewController(detailController, animated: true)
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
        BlogAPI.getABlog{(blogs,error) in
            if let validError = error{
                print(validError.localizedDescription)
                return
            }
            self.blogs = blogs
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }
}//end

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailController.currentBlog = blogs[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
    
            let deletedBlogID = blogs[indexPath.row].blogID
            BlogAPI.deleteABlog(with: Int(deletedBlogID!)!, completion: { (error) in
                if error == nil{
                    DispatchQueue.main.async {
                        self.blogs.remove(at: indexPath.row)
                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                }
            })
        }
    }
}


extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BlogCell.cellIdentifier) as? BlogCell else { return UITableViewCell() }
        return configured(blogCell: cell, withBlog: blogs[indexPath.row])
        }
    
    func configured(blogCell: BlogCell, withBlog blog: Blog) -> BlogCell{
        blogCell.blogTitleLabel.text = blog.title
        blogCell.blogDetailLabel.text = blog.body
        return blogCell
    }
}
