//
//  DeleteUserFeed.swift
//  instagram
//
//  Created by 장나리 on 2023/05/23.
//

import Foundation
 
struct DeleteUserFeed: Decodable{
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: String?
}
