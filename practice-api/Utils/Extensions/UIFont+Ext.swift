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

  static func Sunflower(weight: SunflowerType = .medium, size: CGFloat = 10) -> UIFont {
    return UIFont(name: "Sunflower-\(weight)", size: size)!
  }

}
