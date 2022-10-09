//
//  NetworkingManager.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//

import UIKit

enum NetworkError: Error {
  case networkingError
  case dataError
  case parseError
}

class NetworkingManager {

  static let shared = NetworkingManager()
  private init() {}

  typealias CatsError = (Result<[Cats], NetworkError>) -> Void

  func fetchData(page: Int, completion: @escaping CatsError) {
    print(#function)
    guard let url = URL(string: "\(API.key)v1/images/search?\(API.format)&\(API.limit)&page=\(page)") else { return }

    getData(url: url) { result in
      completion(result)
    }
  }
  // MARK: - GET 메서드
  private func getData(url: URL, completion: @escaping CatsError) {
    print(#function)
    var request = URLRequest(url: url)
    request.httpMethod = "GET"

    URLSession.shared.dataTask(with: request) { data, response, error in
      guard error == nil else {
        completion(.failure(.networkingError))
        return
      }

      guard let safeData = data,
            let cats = self.parseJSON(safeData) else {
        completion(.failure(.dataError))
        return
      }

      completion(.success(cats))
    }.resume()

  }
// MARK: - 데이터 검사 메서드
  private func parseJSON(_ catsData: Data) -> [Cats]? {
    print(#function)
    do {
      let decoder = JSONDecoder()
      let catsData = try decoder.decode(CatsData.self, from: catsData)
      return catsData
    } catch {
      return nil
    }
  }

  // MARK: - POST 메서드
  private func postData(url: URL, completion: @escaping CatsError) {


  }

}
