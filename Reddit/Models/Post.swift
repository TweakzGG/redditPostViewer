//
//  Post.swift
//  Reddit
//
//  Created by Jackson Barnes on 9/3/21.
//

import Foundation

struct RedditResponse: Codable {
    let data: ResponseData
}
struct ResponseData: Codable{
    let children: [PostData]
}
struct PostData: Codable {
    let data: Post
}
struct Post: Codable {
    let title: String
    let ups: Int
    let totalAwardsReceived: Int
    let numComments: Int
    
}
