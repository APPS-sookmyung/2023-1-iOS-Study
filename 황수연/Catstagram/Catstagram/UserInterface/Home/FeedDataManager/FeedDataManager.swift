//
//  FeedDataManager.swift
//  Catstagram
//
//  Created by Suyeon Hwang on 2023/05/16.
//

import Alamofire

class FeedDataManager {
    func feedDataManager(_ parameters: FeedAPIInput, _ viewController: HomeViewController) {
        // AlamoFire를 통해 받아오기
        // reponseDecodable의 of에는 어떤 틀로 받아올 것인지를 알려줘야 함. -> FeedModel
        // completionHandler는 서버와의 연동 성공 시 어떤 행동을 할 지. 성공했을 때 데이터명은 response로
        AF.request("https://api.thecatapi.com/v1/images/search?api_key=live_oL34Rmqu6LdoRtyoiX2Lf0ikQ3VRBDyVrA3ZNBPKXfj7GkxVdo6EdpuwAWU1snMB", method: .get, parameters: parameters).validate().responseDecodable(of: [FeedModel].self) { response in
            switch response.result {
            case .success(let result):
                // 성공했을 때는 result에 넣어줌
                viewController.successAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
