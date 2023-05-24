//
//  FeedAPIInput.swift
//  Catstagram
//
//  Created by 정나윤 on 2023/05/17.
//

struct FeedAPIInput : Encodable {
    var limit : Int?
    var page : Int?
    var api_key : String?

}
