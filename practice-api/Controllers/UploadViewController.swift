//
//  UploadViewController.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//
import UIKit

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

  // MARK: - 메서드
  // 업로드뷰 버튼
  private func setupButton() {
    uploadView.selectButton.addTarget(self, action: #selector(selecButtonTapped), for: .touchUpInside)
    uploadView.uploadButton.addTarget(self, action: #selector(uploadButton), for: .touchUpInside)
    uploadView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
  }

  // 네비게이션바 셋업
  private func setupNavbar() {
    self.title = "업로드"
  }


  // MARK: - 셀렉터
  // 사진 선택 버튼
  @objc func selecButtonTapped() {
    let alert = UIAlertController()
    let albumButton = UIAlertAction(title: "앨범 들어가기", style: .default) { [weak self] _ in
      guard let self = self else { return }
      self.imagePicker.delegate = self
      self.imagePicker.allowsEditing = true
      self.present(self.imagePicker, animated: true)
    }
    let cameraButton = UIAlertAction(title: "카메라앱 들어가기", style: .default) { _ in
      print("카메라에 접근합니다.")
    }
    let cancelButton = UIAlertAction(title: "닫기", style: .cancel) { _ in
      print("닫습니다.")
    }

    alert.addAction(albumButton)
    alert.addAction(cameraButton)
    alert.addAction(cancelButton)

    self.present(alert, animated: true)
  }

  // 사진 업로드 버튼
  @objc func uploadButton() {
    //  insert 해야함
  }

  // 사진 삭제 버튼
  @objc func deleteButtonTapped() {
    uploadView.imageView.image = nil
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
