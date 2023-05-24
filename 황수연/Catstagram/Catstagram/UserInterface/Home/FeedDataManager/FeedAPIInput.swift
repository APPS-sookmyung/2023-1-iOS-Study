//
//  FeedAPIInput.swift
//  Catstagram
//
//  Created by Suyeon Hwang on 2023/05/16.
//

// Encodable 이란 데이터를 바꿔서 보내준다는 뜻
struct FeedAPIInput: Encodable {
    var limit: Int?
    var page: Int?
    
}
