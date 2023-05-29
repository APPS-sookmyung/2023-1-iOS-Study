//
//  FeedAPIInput.swift
//  instagram
//
//  Created by 장나리 on 2023/05/16.
//

struct FeedAPIInput : Encodable {
    var limit : Int?
    var page : Int?
    var api_key : String?
    
}
