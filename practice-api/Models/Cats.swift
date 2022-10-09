//
//  Cats.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//

import UIKit

typealias CatsData = [Cats]

struct Cats: Codable {
  let id: String?
  let url: String?
  let width, height: Int?
}

