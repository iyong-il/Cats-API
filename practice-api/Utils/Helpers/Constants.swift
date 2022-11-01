//
//  Constants.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//

import Foundation

// MARK: - 고양이 테이블뷰 셀 아이디
public enum CatsCell {
  static let catCellID = "CatsCell"
}

// MARK: - 좋아요 셀 아이디
public enum Like {
  static let likeCellID = "likeCell"
  static let likeHeader = "likeListHeader"
}

// MARK: - 업로드 셀 아이디
public enum Upload {
  static let uploadCellID = "uploadCell"
  static let uploadHeader = "uploadListHeader"
}

// MARK: - API 키 값
public enum APIs {
  static let key = "https://api.thecatapi.com/"
  static let format = "format=json"
  static let limit = "limit=10"
  static let myKey = "live_Wc1JhfSSmE2VHu26BstKc1LrAJF5pJCgiR07U4Ne1kVY1ZosLxVvIFtKxIidCaLq"
  static let contentType = "multipart/form-data"
}
