//
//  UserFeedDataManager.swift
//  Catstagram
//
//  Created by Suyeon Hwang on 2023/05/16.
//

import Alamofire

class UserFeedDataManager {
    // MARK: - 유저 피드 조회 API
    func getUserFeed(_ viewController: ProfileViewController,
                     _ userID: Int = 2) {
        // 통신
        AF.request("https://edu-api-ios-test.softsquared.com/users/\(userID)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: UserFeedModel.self) { response in
            switch response.result {
            case .success(let result):
                // 성공했을 때는 result에 넣어줌
                viewController.successFeedAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - 게시물 삭제 API
    func deleteUserFeed(_ viewController: ProfileViewController,
                        _ postIdx: Int) {
           // 통신
           AF.request("https://edu-api-ios-test.softsquared.com/posts/\(postIdx)/status",
                      method: .patch,
                      parameters: nil)
               .validate()
               .responseDecodable(of: DeleteUserFeed.self) { response in
                   
               switch response.result {
               case .success(let result):
                   // 성공했을 때는 result에 넣어줌
                   viewController.successDeletePostAPI(result.isSuccess ?? false)
               case .failure(let error):
                   print(error.localizedDescription)
               }
           }
       }
}
