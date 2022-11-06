//
//  CatsCell.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//

import UIKit
import SDWebImage

protocol CatsCellDelegate: AnyObject {
  func handleCatsCell()
}

final class CatsTableViewCell: UITableViewCell {

  // MARK: - 속성
  var cats: Cats? {
    didSet {
      guard let cats = cats else { return }
      loadImage(with: cats.url)
    }
  }

  weak var delegate: CatsCellDelegate?

  @IBOutlet weak var mainImageView: UIImageView!
  @IBOutlet weak var LikeButton: UIButton!


  // MARK: - 라이프사이클
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()

  }

  // 셀 재사용 전 호출되는 메서드
  override func prepareForReuse() {
    super.prepareForReuse()

    self.mainImageView.image = nil
  }


// MARK: - 메서드
  // UI셋업 메서드
  private func setupUI() {
    self.mainImageView.contentMode = .scaleAspectFit
    self.mainImageView.layer.borderWidth = 1
    self.mainImageView.layer.borderColor = UIColor.black.cgColor
    self.mainImageView.clipsToBounds = true
    self.mainImageView.layer.cornerRadius = 16
    self.mainImageView.layer.masksToBounds = true
  }

  // 버튼이 눌렸을 때 메서드
  @IBAction func likeButtonTapped(_ sender: UIButton) {
    sender.isSelected.toggle()

    if sender.isSelected {
      print(#fileID, #function, #line, "- 좋아요")
      delegate?.handleCatsCell()
    }else {
      print(#fileID, #function, #line, "- 좋아요해제")

    }
  }

  // 이미지로드
  func loadImage(with imageUrl: String?) {

    guard let urlString = imageUrl,
          let url = URL(string: urlString) else { return }

        mainImageView.sd_setImage(with: url)
  }

}
