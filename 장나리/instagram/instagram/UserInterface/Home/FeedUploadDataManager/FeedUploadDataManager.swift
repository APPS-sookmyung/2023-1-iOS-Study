//
//  FeedUploadDataManager.swift
//  instagram
//
//  Created by 장나리 on 2023/05/17.
//

import Alamofire

class FeedUploadDataManager{
    func posts(_ viewController : HomeViewController, _ parameter : FeedUploadInput){
        AF.request("https://edu-api-ios-test.softsquared.com", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil).validate().responseDecodable(of: FeedUploadModel.self){ response in
            switch response.result{
            case .success(let result):
                if result.isSuccess{
                    print("성공")
                }else{
                    print(result.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
