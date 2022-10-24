//
//  UploadCollectionViewCell.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//

import UIKit

final class UploadCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var uploadImageView: UIImageView!

  var uploadDeleteButtonPressed: (UploadCollectionViewCell) -> Void = { (sender) in }

    override func awakeFromNib() {
        super.awakeFromNib()
      uploadImageView.backgroundColor = .yellow
      uploadImageView.layer.cornerRadius = 8
      uploadImageView.layer.borderColor = UIColor.black.cgColor
      uploadImageView.layer.borderWidth = 0.2
      uploadImageView.contentMode = .scaleAspectFit
    }




  @IBAction func deleteButtonTapped(_ sender: UIButton) {
    uploadDeleteButtonPressed(self)
  }


}
