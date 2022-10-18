//
//  CatsCell.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//

import UIKit

final class CatsCell: UITableViewCell {

  // MARK: - 속성
  var cats: Cats? {
    didSet {
      setupUIwithData()
    }
  }

  @IBOutlet weak var mainImageView: UIImageView!
  @IBOutlet weak var LikeButton: UIButton!
  var catsID: String?

  // 셀 재사용 전 호출되는 메서드
  override func prepareForReuse() {
    super.prepareForReuse()

    self.mainImageView.image = nil
  }
  // MARK: - 라이프사이클
  // 뷰디드로그
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()

  }


  // UI셋업 메서드
  private func setupUI() {
    self.mainImageView.contentMode = .scaleToFill
    self.mainImageView.layer.borderWidth = 1
    self.mainImageView.layer.borderColor = UIColor.black.cgColor
    self.mainImageView.clipsToBounds = true
    self.mainImageView.layer.cornerRadius = 16
    self.mainImageView.layer.masksToBounds = true
  }

  // 버튼이 눌렸을 때 메서드
  @IBAction func likeButtonTapped(_ sender: UIButton) {
    sender.isSelected.toggle()
    // 아직 구현 전
  }

  // 이미지와 아이디를 한번에 넘기기위한 메서드
  private func setupUIwithData() {
    guard let cats = cats else { return }
    loadImage(with: cats.url)
    catsID = cats.id
  }

  // 이미지로드
  func loadImage(with imageUrl: String?) {
    print(#function)
    guard let urlString = imageUrl,
          let url = URL(string: urlString) else { return }

    DispatchQueue.global().async {
      guard let data = try? Data(contentsOf: url) else { return }
      
      guard urlString == url.absoluteString else { return }

      DispatchQueue.main.async {
        self.mainImageView.image = UIImage(data: data)
      }
    }

  }

}