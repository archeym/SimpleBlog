//
//  BlogAPI.swift
//  SimpleBlog
//
//  Created by Arkadijs Makarenko on 27/04/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import Foundation

class BlogAPI{
    
    //GET https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs
    static func getAllBlogs(competion: @escaping ([Blog],Error?)->Swift.Void) {
    let url = URL(string: "https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs")
        var urlRequest = URLRequest(url:url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("token", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let err = error as NSError? {
                print(err.localizedDescription)
                competion([],error)
                return
            }
            guard let validData = data else {return}
            
            do {
                guard let responseJSON = try JSONSerialization.jsonObject(with: validData, options: []) as? [[String:Any]] else {return}
                
                let allBlogs : [Blog] = responseJSON.map({ rawBlog in
                    
                    let blog = Blog(dictionary: rawBlog)
                    return blog!
                })
                competion(allBlogs,nil)
                
            }catch let jsonError as NSError {
                print(jsonError.localizedDescription)
                competion([],jsonError)
                
            }
        }
        dataTask.resume()
    }
    //DELETE https://nextacademy-ios-blog.herokuapp.com/api/v1/comments/<ID>
    static func deleteAllBlogs(with id: Int) {
        
        let url = URL(string: "https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs/\(id)")
        var urlRequest = URLRequest(url:url!)
        
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("token", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let err = error as NSError? {
                print(err.localizedDescription)
                return
            }
        }
        dataTask.resume()
    }
    
    //    PUT https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs
    
    static func updateABlog(with blog: Blog, completion:@escaping (Blog, Error?)->Swift.Void){
        let url = URL(string: "https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs/\(blog.blogID)")
        var urlReq = URLRequest(url: url!)
        
        urlReq.httpMethod = "PUT"
        urlReq.setValue("token", forHTTPHeaderField: "Authorization")
        urlReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        // create a dictionary from Blog information
        guard let dictionary : [String: Any] = ["blog": ["title": blog.title, "body": blog.body]] else {return}
        
        // convert dictionary to Data
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        
        
        // put the data in the resquest body
        urlReq.httpBody = jsonData
        
        let dataTask = session.dataTask(with: urlReq)
        
        dataTask.resume()
        
    }
    //    POST https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs
    
    static func createABlog(with blog: Blog, completion:@escaping (Blog, Error?)->Swift.Void){
        let url = URL(string: "https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs")
        var urlReq = URLRequest(url: url!)
        
        urlReq.httpMethod = "POST"
        urlReq.setValue("token", forHTTPHeaderField: "Authorization")
        urlReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        // create a dictionary from Blog information
        guard let dictionary : [String: Any] = ["blog": ["title": blog.title, "body": blog.body]] else {return}
        
        // convert dictionary to Data
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        
        
        // put the data in the resquest body
        urlReq.httpBody = jsonData
        
        let dataTask = session.dataTask(with: urlReq)
        
        dataTask.resume()
        
    }
    
    
    
}//end











