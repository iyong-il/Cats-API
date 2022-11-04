//
//  MainApiService.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/21.
//

import UIKit
import Alamofire


struct CatsService {
  static let shared = CatsService()
  private init() {}
  
  typealias GetError = (Result<[Cats], Error>) -> Void

  func setupAFDatas(page: Int = 1, completion: @escaping GetError)  {
    let url = "\(APIs.key)v1/images/search?"
    let params = [
      "format": "json",
      "limit": "10",
      "page": "\(page)"]

    AF.request(url, method: .get, parameters: params)
      .responseData { response in
        switch response.result {
        case .success(let data):

          do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(CatsData.self, from: data)
            completion(.success(result))

          }catch {
            completion(.failure(error))
          }

        case .failure(let error):
          completion(.failure(error))

        }
      }



  }

}
