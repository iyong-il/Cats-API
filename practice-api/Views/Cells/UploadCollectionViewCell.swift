//
//  UploadCollectionViewCell.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//

import UIKit

class UploadCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var uploadImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
      uploadImageView.backgroundColor = .yellow
    }




  @IBAction func deleteButtonTapped(_ sender: UIButton) {
    
  }


}
