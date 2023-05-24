//
//  FeedDataManager.swift
//  Catstagram
//
//  Created by 정나윤 on 2023/05/17.
//

import Alamofire

class FeedDataManager {
    func feedDataManager(_ parameters : FeedAPIInput, _ viewController : HomeViewController) {
        //AF: Alamofire
        //FeedModel 에서 값을 배열로 받아옴
        //FeedAPIInput 에서 받은 값으로 parameters
        // 성공했을 때 결과를 response 로
        AF.request("https://api.thecatapi.com/v1/images/search", method: .get, parameters: parameters ).validate().responseDecodable(of: [FeedModel].self){ response in
                switch response.result {
                case .success(let result) :
                    // 성공했을 때 viewController에 있는 successAPI 받아옴
                    viewController.successAPI(result)
                case .failure(let error) :
                    // 실패 원인 알기 위함 
                    print(error.localizedDescription)
                }
        }
    }
}
