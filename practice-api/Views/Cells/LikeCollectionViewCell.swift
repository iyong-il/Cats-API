//
//  LikeCollectionViewCell.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//

import UIKit

final class LikeCollectionViewCell: UICollectionViewCell {

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


  @IBAction func deleteButtonTapped(_ sender: UIButton) {
    likeDeleteButtonPressed(self)
  }



}
