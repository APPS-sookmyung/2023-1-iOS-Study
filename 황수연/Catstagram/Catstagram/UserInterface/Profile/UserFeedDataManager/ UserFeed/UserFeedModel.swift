//
//  UserFeedModel.swift
//  Catstagram
//
//  Created by Suyeon Hwang on 2023/05/16.
//

struct UserFeedModel: Decodable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: UserFeedModelResult?
}

struct UserFeedModelResult: Decodable {
    let isMyFeed: Bool?
    let userInfo: GetUserInfo?
    let userPosts: [GetUserPosts]?
}

struct GetUserInfo: Decodable {
    let userIdx: Int?
    let nickName: String?
    let name: String?
    let profileImgUrl: String?
    let website: String?
    let introduction: String?
    let followerCount: Int?
    let followeeCount: Int?
    let postCount: Int?
}

struct GetUserPosts: Decodable {
    let postIdx: Int?
    let postImgUrl: String?
}

