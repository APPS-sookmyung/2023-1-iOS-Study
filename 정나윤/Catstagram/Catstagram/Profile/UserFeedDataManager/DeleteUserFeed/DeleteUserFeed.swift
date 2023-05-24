//
//  DeleteUserFeed.swift
//  Catstagram
//
//  Created by 정나윤 on 2023/05/20.
//

import Foundation


struct DeleteUserFeed : Decodable {
    let isSuccess : Bool?
    let code: Int?
    let message: String?
    let result: String?
}
