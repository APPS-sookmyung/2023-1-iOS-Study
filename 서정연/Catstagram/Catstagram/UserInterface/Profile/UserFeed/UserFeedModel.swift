//
//  UserFeedModel.swift
//  Catstagram
//
//  Created by Seo Cindy on 2023/05/17.
//

import Foundation

struct UserFeedModel : Decodable{
    // 서버 응답 쿼리
    let isSuccess : Bool?
    let code : Int?
    let message : String?
    let result : UserFeedModelResult?
}

struct UserFeedModelResult : Decodable{
    let _isMyFeed : Bool?
    let getUserInfo : GetUserInfo?
    let getUserPosts : [GetUserPosts]?
}

struct GetUserInfo : Decodable{
    let userIdx : Int?
    let nickName : String?
    let name : String?
    let profileImgUrl : String?
    let website : String?
    let introduction : String?
    let followerCount : Int?
    let followingCount : Int?
    let postCount: Int?
}

struct GetUserPosts : Decodable{
    let postIdx : Int?
    let postImgUrl : String?
}
