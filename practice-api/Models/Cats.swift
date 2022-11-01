//
//  Cats.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//

import UIKit

// 데이터를 묶기위해
typealias CatsData = [Cats]


// MARK: - 서버에서 주는 데이터
struct Cats: Codable {
  let id: String?
  var url: String?
  let width, height: Int?
}

// MARK: - 업로드 데이터
struct UploadData: Codable {
    let id: String
    let url: String
    let width, height: Int
    let originalFilename: String
    let pending, approved: Int

    enum CodingKeys: String, CodingKey {
        case id, url, width, height
        case originalFilename = "original_filename"
        case pending, approved
    }
}
