//
//  UploadCats.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/11/04.
//

import UIKit

// MARK: - 업로드하면 서버에 저장되는 데이터
struct UploadCats: Codable {
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
