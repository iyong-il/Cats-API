//
//  MainApiService.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/21.
//

import UIKit
import Alamofire

enum AF_API {

  typealias DataError = (Result<[Cats], Error>) -> Void

  static func setupAFDatas(page: Int, completion: @escaping DataError)  {
    let url = "\(API.key)v1/images/search?"
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

  

//  static func postAFDatas() {
//    let url = "\(API.myKey)v1/images/upload"
//    var request = URLRequest(url: URL(string: url)!)
//    request.httpMethod = "POST"
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.timeoutInterval = 10
//
//    let params = [
//      "id": "아이디",
//      "url": "유알엘",
//      "width": "넓이",
//      "height": "높이",
//      "originalFilename": "파일이름",
//      "pending": "펜딩",
//      "approved": "접근"
//    ] as Dictionary
//
//    // MARK: - 업로드 데이터
//    struct UploadData: Codable {
//      let id: String
//      let url: String
//      let width, height: Int
//      let originalFilename: String
//      let pending, approved: Int
//
//      enum CodingKeys: String, CodingKey {
//        case id, url, width, height
//        case originalFilename = "original_filename"
//        case pending, approved
//      }
//    }
//
//    do {
//      try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
//    } catch {
//
//    }
//
//
//    AF.request(request).responseString { response in
//      switch response.result {
//      case .success:
//        print("성공")
//      case .failure(let error):
//        print(error.localizedDescription)
//      }
//    }
//


  }















