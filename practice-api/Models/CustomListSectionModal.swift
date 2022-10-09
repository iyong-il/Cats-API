//
//  CustomListSectionModal.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/10.
//

import UIKit

// MARK: - 좋아요, 업로드 목록 열거형
enum CustomListSectionModal {
  case like([LikeCategories])
  case upload([UploadCategories])
}

// MARK: - 좋아요 카테고리
struct LikeCategories {
  var catsInfo: CatsData?
  var isSelected: Bool = false

  static func getLikeCats() -> CatsData {
    let array: [Cats] = []

    return array
  }

}
// MARK: - 업로드 카테고리
struct UploadCategories {
  var uploadImageView: UIImageView?
  let catsID: String?
  var isSelected: Bool = false

}
