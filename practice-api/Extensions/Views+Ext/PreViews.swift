//
//  PreViews.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//

import Foundation
import SwiftUI


// MARK: - 뷰 미리보기
#if DEBUG

extension UIViewController {
  private struct VCRepresentable: UIViewControllerRepresentable {

    let viewController: UIViewController

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
    func makeUIViewController(context: Context) -> some UIViewController {
      return viewController
    }

  }
  func getPreview() -> some View {
    VCRepresentable(viewController: self)
  }
}
extension UIView {
  private struct ViewRepresentable: UIViewRepresentable {

    let uiview: UIView

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
    func makeUIView(context: Context) -> some UIView {
      return uiview
    }

  }
  func getPreview() -> some View {
    ViewRepresentable(uiview: self)
  }
}
#endif
