//
//  MainApiService.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/21.
//

import UIKit
import Alamofire

// MARK: - 네트워킹 시도 두번째 / Alamofire
enum API {


  // MARK: - GET 메서드
  typealias GetError = (Result<[Cats], Error>) -> Void

  static func setupAFDatas(page: Int = 1, completion: @escaping GetError)  {
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

  // MARK: - POST 메서드
  // 사진을 등록하면 밑에 params형태로 데이터가 저장이 되는데 이걸 내가 어떻게 접근해서 등록을 해야할까...?
  // postman으로 등록했을 때는 사진 url만 넣었더니 등록이 됐는데
  // 이걸 어떻게 할 수 있을까 - 확실히 공부한 기간이 티가 나네
  // post를 구현하면 delete는 금방 구현 할거 같은데
  typealias PostError = (Result<[UploadData], Error>) -> Void

  static func postAFDatas(file: String, completion: @escaping PostError) {
    let url = "\(APIs.myKey)v1/images/upload"
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "POST"

    let params = [
      "file": file
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
