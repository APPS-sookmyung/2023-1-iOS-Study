//
//  FeedUploadDataManager.swift
//  Catstagram
//
//  Created by Suyeon Hwang on 2023/05/16.
//

import Alamofire

class FeedUploadDataManager {
    func posts(_ viewController: HomeViewController, _ parameter: FeedUploadInput) {
        // body를 보낼 때는 JSON으로 보냄 -> encoding에는 JSONParameterEncoder.default 로
        AF.request("https://edu-api-ios-test.softsquared.com/posts", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil).validate().responseDecodable(of: FeedUploadModel.self) { response in
            switch response.result{
            case .success(let result):
                if result.isSuccess {
                    print("성공")
                }
                else {
                    print(result.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
