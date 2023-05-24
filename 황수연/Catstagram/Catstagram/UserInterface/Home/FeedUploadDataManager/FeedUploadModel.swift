//
//  FeedUploadModel.swift
//  Catstagram
//
//  Created by Suyeon Hwang on 2023/05/16.
//

struct FeedUploadModel: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: FeedUploadResult?
}

struct FeedUploadResult: Decodable {
    var postIdx: Int?
}
