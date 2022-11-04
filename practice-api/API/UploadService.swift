//
//  UploadService.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/11/04.
//

import UIKit
import Alamofire

struct UploadService {
  static let shared = UploadService()
  private init() {}
  
  typealias UploadError = (Result<[UploadCats], Error>) -> Void

  func postAFDatas(file: String, completion: @escaping UploadError) {
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
