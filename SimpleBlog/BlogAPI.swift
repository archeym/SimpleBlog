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
    
    static func getABlog(competion: @escaping ([Blog],Error?)->Swift.Void) {
    let url = URL(string: "https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs")
        //to change url header we use urlRequest if we only use url the default header is GET
        var urlRequest = URLRequest(url:url!)
        urlRequest.httpMethod = "GET"
        //only for register ->
        //urlRequest.setValue("token", forHTTPHeaderField: "Authorization")
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
                print("JSON Error: \(jsonError.localizedDescription)")
                competion([],jsonError)
            }
        }
        dataTask.resume()
    }
    //DELETE https://nextacademy-ios-blog.herokuapp.com/api/v1/comments/<ID>
    static func deleteABlog(with id: Int, completion: @escaping (Error?) -> Swift.Void ) {
        
        let url = URL(string: "https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs/\(id)")
        var urlRequest = URLRequest(url:url!)
        
        urlRequest.httpMethod = "DELETE"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let err = error as NSError? {
                print("Error: \(err.localizedDescription)")
                return
            }
            completion(nil)
        }
        dataTask.resume()
    }
    
    //PUT https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs
    static func updateABlog(with id: Int,dictionary : [String: Any]){
        if let jasonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted){
        let url = URL(string: "https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs/\(id)")
        var urlReq = URLRequest(url: url!)
        urlReq.httpBody = jasonData
        urlReq.httpMethod = "PUT"
        urlReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let dataTask = URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
            if let err = error as NSError? {
                print("Error:\(err.localizedDescription)")
                return
                }
            }
            dataTask.resume()
        }
    }
    //POST https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs
    static func createABlog(dictionary : [String: Any]){
        if let jasonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted){
        let url = URL(string: "https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs")
        var urlReq = URLRequest(url: url!)
        
        urlReq.httpBody = jasonData
        urlReq.httpMethod = "POST"
        urlReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
            if let err = error as NSError? {
                print("Error:\(err.localizedDescription)")
                return
                }
                
            }
            dataTask.resume()
        }
    }
    
}//end

