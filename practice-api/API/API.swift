//
//  MainApiService.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/21.
//

import UIKit
import Alamofire

// MARK: - 네트워킹 시도 두번째
enum API {

  typealias GetError = (Result<[Cats], Error>) -> Void

  // MARK: - GET 메서드
  static func setupAFDatas(page: Int, completion: @escaping GetError)  {
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



  }// GET

  typealias PostError = (Result<[UploadData], Error>) -> Void

  static func postAFDatas(completion: @escaping PostError) {
    let url = "\(APIs.myKey)v1/images/upload"
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "POST"

    let params = [
      "id": "아이디",
      "url": "유알엘",
      "width": "넓이",
      "height": "높이",
      "originalFilename": "파일이름",
      "pending": "펜딩",
      "approved": "접근"
    ] as Dictionary


    do {
      try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
    } catch {
      return
    }

    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")


    AF.request(request).responseString { response in
      switch response.result {
      case .success:
        print("성공")
      case .failure(let error):
        print(error.localizedDescription)
      }
    }

//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.timeoutInterval = 10



  }









}
