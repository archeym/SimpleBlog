//
//  Blog.swift
//  SimpleBlog
//
//  Created by Arkadijs Makarenko on 27/04/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import Foundation

class Blog {
    
    let blogID : Int
    var title : String = "Untitled"
    var body : String?
    
    init() {
        blogID = 1001
        title = ""
        body = ""
    }
    
    init?(dictionary : [String:Any]){
        guard let validID = dictionary["id"] as? Int else { return nil }
        
        blogID = validID
        title = dictionary["title"] as? String ?? "Untitled"
        body = dictionary["body"] as? String
    }
    
}
