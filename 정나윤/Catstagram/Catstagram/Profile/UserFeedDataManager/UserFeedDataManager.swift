//
//  UserFeedDataManager.swift
//  Catstagram
//
//  Created by 정나윤 on 2023/05/17.
//

import Alamofire

class UserFeedDataManager {
    func getUserFeed(_ viewController : ProfileViewController, _ userID: Int = 2) {
        //통신
        AF.request("https://edu-api-ios-test.softsquared.com/users/\(userID)",
                   method: .get,
                   parameters: nil ).validate().responseDecodable(of: UserFeedModel.self) { response in
                switch response.result {
                case .success(let result) :
                    viewController.successFeedAPI(result)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
        }
    }
}

