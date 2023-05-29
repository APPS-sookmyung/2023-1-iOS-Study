//
//  DeleteUserFeed.swift
//  Catstagram
//
//  Created by Seo Cindy on 2023/05/24.
//

import Foundation

struct DeleteUserFeed : Decodable{
    let isSuccess : Bool?
    let code : Int?
    let message : String?
    let result : String?
}
