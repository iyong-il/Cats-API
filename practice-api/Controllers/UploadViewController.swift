//
//  UploadViewController.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//
import UIKit
//import PhotosUI

final class UploadViewController: UIViewController {

  // MARK: - 속성
  private let uploadView = UploadView()

  // 이미지 피커
  private let imagePicker = UIImagePickerController()

  // MARK: - 라이프 사이클
  // 로드뷰
  override func loadView() {
    self.view = uploadView
  }

  // 뷰디드로드
  override func viewDidLoad() {
    super.viewDidLoad()
    setupButton()
    setupNavbar()
    
  }

  // 업로드뷰 버튼 메서드
  private func setupButton() {
    uploadView.selectButton.addTarget(self, action: #selector(selecButtonTapped), for: .touchUpInside)
    uploadView.uploadButton.addTarget(self, action: #selector(uploadButton), for: .touchUpInside)
    uploadView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
  }

  // MARK: - 셀렉터
  // 사진 선택 버튼
  @objc func selecButtonTapped() {
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    self.present(imagePicker, animated: true)
  }

  // 사진 업로드 버튼
  @objc func uploadButton() {
    //    append 해야함
  }

  // 사진 삭제 버튼
  @objc func deleteButtonTapped() {
    uploadView.imageView.image = nil
  }

  // 네비게이션바 셋업 메서드
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
extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let catsImage = info[.editedImage] as? UIImage else { return }
    uploadView.imageView.image = catsImage

    uploadView.imageView.layer.masksToBounds = true
    uploadView.imageView.clipsToBounds = true

    dismiss(animated: true)
  }


}
