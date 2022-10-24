//
//  Utilities.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/21.
//

import UIKit

final class Utilities {

  // 업로드관련 버튼
  func makeButton(text: String) -> UIButton {
    let button = UIButton()
    button.setTitle(text, for: .normal)
    button.titleLabel?.font = UIFont.Sunflower(size: 24, weight: .bold)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 8
    return button
  }
  
}
