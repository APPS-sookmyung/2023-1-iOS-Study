//
//  UserFeedDataManager.swift
//  Catstagram
//
//  Created by Suyeon Hwang on 2023/05/16.
//

import Alamofire

class UserFeedDataManager {
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
}
