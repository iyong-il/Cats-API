//
//  NetworkingManager.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//

import UIKit
// MARK: - 에러타입정의
enum NetworkError: Error {
  case networkingError
  case dataError
  case parseError
}

final class NetworkingManager {

  // 싱글톤으로 생성
  static let shared = NetworkingManager()
  private init() {}

  // MARK: - Result타입 치환
  // Result타입을 그냥 짧게 쓰고 싶어서
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

      guard let safeData = data else {
        completion(.failure(.dataError))
        return
      }

      guard let cats = self.parseJSON(safeData) else {
        completion(.failure(.parseError))
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





}
