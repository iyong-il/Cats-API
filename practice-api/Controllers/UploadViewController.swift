//
//  UploadViewController.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//

import UIKit

import UIKit
import PhotosUI

final class UploadViewController: UIViewController {

  private let uploadView = UploadView()

  // MARK: - 로드뷰
  override func loadView() {
    self.view = uploadView
  }

  // MARK: - 뷰디드로드
  override func viewDidLoad() {
    super.viewDidLoad()
    setupButton()
    setupNavbar()

  }
  // MARK: - 업로드뷰 버튼 메서드
  private func setupButton() {
    uploadView.selectButton.addTarget(self, action: #selector(selecButtonTapped), for: .touchUpInside)
    uploadView.uploadButton.addTarget(self, action: #selector(uploadButton), for: .touchUpInside)
    uploadView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)

  }
  // MARK: - 셀렉터 / 사진 선택 버튼
  @objc func selecButtonTapped() {
    var configuration = PHPickerConfiguration()
    configuration.selectionLimit = 0
    configuration.filter = .any(of: [.images])

    // 기본설정을 가지고, 피커뷰컨트롤러 생성
    let picker = PHPickerViewController(configuration: configuration)
    // 피커뷰컨트롤러의 대리자 설정
    picker.delegate = self
    // 피커뷰 띄우기
    self.present(picker, animated: true)
  }
  // MARK: - 셀렉터 / 사진 업로드 버튼
  @objc func uploadButton() {

  }
// MARK: - 셀렉터 / 사진 삭제 버튼
  @objc func deleteButtonTapped() {
    uploadView.imageView.image = nil
  }
// MARK: - 네비게이션바 셋업 메서드
  private func setupNavbar() {
    self.title = "업로드"

    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .white
    navigationController?.navigationBar.tintColor = .systemBlue
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
  }

}
// MARK: - 확장 / 피커뷰
extension UploadViewController: PHPickerViewControllerDelegate {
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    picker.dismiss(animated: true)

    let itemProvider = results.first?.itemProvider

    if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
      itemProvider.loadObject(ofClass: UIImage.self) { (image, errer) in
        DispatchQueue.main.async {
          self.uploadView.imageView.image = image as? UIImage
        }
      }
    } else {

    }
  }


}
