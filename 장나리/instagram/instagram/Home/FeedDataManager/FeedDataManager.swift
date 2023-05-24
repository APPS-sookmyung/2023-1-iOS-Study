//
//  FeedDataManager.swift
//  instagram
//
//  Created by 장나리 on 2023/05/16.
//

import Alamofire

class FeedDataManager {
    func FeedDataManager(_ parameters : FeedAPIInput, _ viewController : HomeViewController) {
        AF.request("https://api.thecatapi.com/v1/images/search", method: .get, parameters: parameters).validate().responseDecodable(of:[FeedModel].self){ response in
            switch response.result{
            case .success(let result):
                viewController.successAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
