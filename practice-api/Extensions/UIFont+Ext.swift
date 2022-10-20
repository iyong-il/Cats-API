//
//  UIFont+Ext.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/21.
//

import UIKit

extension UIFont {

  enum SunflowerType: String {
    case bold = "Bold"
    case medium = "Medium"
    case light = "Light"
  }

  // 폰트 메서드
  static func Sunflower(size: CGFloat = 10, weight: SunflowerType = .medium ) -> UIFont {
    return UIFont(name: "Sunflower-\(weight)", size: size)!
  }

}
