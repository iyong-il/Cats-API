//
//  UploadView.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//

import UIKit
import SnapKit
import Then

final class UploadView: UIView {
  
  let deleteButton = UIButton().then {
    $0.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
    $0.tintColor = .lightGray
    $0.contentMode = .scaleToFill
  }
  
  lazy var imageView = UIImageView().then {
    $0.layer.cornerRadius = 16
    $0.layer.borderColor = UIColor.black.cgColor
    $0.layer.borderWidth = 1
    $0.contentMode = .scaleAspectFit
  }
  
  let selectButton: UIButton = {
    let button = Utilities().makeButton(text: "사진 선택하기")

    return button
  }()
  
  let uploadButton: UIButton = {
    let button = Utilities().makeButton(text: "사진 업로드하기")

    return button
  }()
  
  private lazy var stackView = UIStackView().then {
    $0.addArrangedSubview(selectButton)
    $0.addArrangedSubview(uploadButton)
    
    $0.axis = .vertical
    $0.spacing = 15
    $0.alignment = .fill
    $0.distribution = .fillEqually
  }

  // MARK: - 필수생성자
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  // MARK: - 라이프사이클
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  // 오토레이아웃
  override func updateConstraints() {
    setupSnp()
    super.updateConstraints()
  }

  // 셋업
  private func setup() {
    self.backgroundColor = .white
    self.addSubview(deleteButton)
    self.addSubview(imageView)
    self.addSubview(stackView)
  }

  // 스냅킷
  private func setupSnp() {
    imageView.snp.makeConstraints {
      $0.height.equalTo(300)
      $0.left.equalToSuperview().offset(10)
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(160)
    }
    
    deleteButton.snp.makeConstraints {
      $0.bottom.equalTo(imageView.snp.top).offset(-15)
      $0.right.equalTo(imageView.snp.right)
    }
    
    selectButton.snp.makeConstraints {
      $0.height.equalTo(60)
    }
    
    stackView.snp.makeConstraints {
      $0.top.equalTo(imageView.snp.bottom).offset(80)
      $0.horizontalEdges.equalTo(imageView.snp.horizontalEdges)
    }
    
  }
  
  
  
}
// MARK: - 뷰 미리보기
#if DEBUG
import SwiftUI

struct UploadView_Previews: PreviewProvider {
  
  static var previews: some View {
    if #available(iOS 14.0, *) {
      UploadView().getPreview()
        .ignoresSafeArea()
    }
    
  }
}
#endif
