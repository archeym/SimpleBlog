//
//  Blog.swift
//  SimpleBlog
//
//  Created by Arkadijs Makarenko on 27/04/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import Foundation

class Blog {
    let blogID : String!
    var title : String = "Untitled"
    var body : String?
    init?(dictionary : [String:Any]) {
        guard let validId = dictionary["id"] as? Int else {return nil}
        blogID = String(validId)
        title = dictionary["title"] as? String ?? ""
        body = dictionary["body"] as? String
    }
    
}
