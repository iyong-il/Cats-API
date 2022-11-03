//
//  LikeCollectionViewCell.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//

import UIKit
import SDWebImage

final class LikeCollectionViewCell: UICollectionViewCell {

  var cats: Cats? {
    didSet {
      print(#fileID, #function, #line, "- 좋아요목록 셀까지 넘어왔다.")
      setupImage()
    }
  }
  
  @IBOutlet weak var likeImageView: UIImageView!

  var likeDeleteButtonPressed: (LikeCollectionViewCell) -> Void = {(sender) in}


    override func awakeFromNib() {
        super.awakeFromNib()
      likeImageView.backgroundColor = .blue
      likeImageView.layer.cornerRadius = 8
      likeImageView.layer.borderColor = UIColor.black.cgColor
      likeImageView.layer.borderWidth = 0.2
      likeImageView.contentMode = .scaleAspectFit
    }

  func setupImage() {
    guard let cats = cats else { return }
    loadImage(with: cats.url)
  }

  func loadImage(with imageUrl: String?) {
    print(#fileID, #function, #line, "- 고양이이미지를 받아오는 중입니다.")
    guard let urlString = imageUrl,
          let url = URL(string: urlString) else { return }
    // SDWebImage로 이미지 받아오기
    likeImageView.sd_setImage(with: url)
  }


  @IBAction func deleteButtonTapped(_ sender: UIButton) {
    likeDeleteButtonPressed(self)
  }



}
