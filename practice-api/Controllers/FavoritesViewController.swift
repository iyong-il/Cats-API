//
//  FavoritesViewController.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//

import UIKit
import SnapKit
import Then

final class FavoritesViewController: UIViewController {



  lazy var collectionView: UICollectionView = {
      let view = UICollectionView(frame: .zero, collectionViewLayout: setupCompositionalLayoutList())
      // 스크롤링 사용할것인지
      view.isScrollEnabled = true
      // 가로 스크롤바 표시 여부
      view.showsHorizontalScrollIndicator = false
      // 세로 스크롤바 표시 여부
      view.showsVerticalScrollIndicator = true
      // contentInset은 컨텐츠에 상하좌우 여백
      view.contentInset = .zero
      // 백그라운드 컬러
      view.backgroundColor = .white
      // subview들이 view의 bounds에 가둬질 수 있는 지를 판단하는 Boolean 값
      view.clipsToBounds = true
      return view
  }()



  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(collectionView)

    self.navigationController?.navigationBar.isHidden = true
    
    collectionView.snp.makeConstraints {
      $0.top.left.right.equalToSuperview()
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
    }

    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.dataSource = self

    // 좋아요 쎌 등록
    collectionView.register(UINib(nibName: String(describing: LikeCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: LikeCell.likeCellID)

    // 업로드 쎌 등록
    collectionView.register(UINib(nibName: String(describing: UploadCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: UploadCell.uploadCellID)

    // 좋아요 헤더 등록
    collectionView.register(UINib(nibName: String(describing: LikeReusableView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LikeCell.likeHeader)

    // 업로드 헤더 등록
    collectionView.register(UINib(nibName: String(describing: UploadReusableView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UploadCell.uploadHeader)
  }








}

// MARK: - 확장 / 컬렉션뷰 데이터소스
extension FavoritesViewController: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }


  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let sectionIndex = indexPath.section

    switch sectionIndex {
    case 0:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikeCell.likeCellID, for: indexPath) as! LikeCollectionViewCell
      return cell

    case 1:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UploadCell.uploadCellID, for: indexPath) as! UploadCollectionViewCell
      return cell

    default:
      return UICollectionViewCell()

    }


  }



}

extension FavoritesViewController: UICollectionViewDelegate {


  // 헤더, 푸터 등록
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

    let sectionIndex = indexPath.section

    switch (kind, sectionIndex) {

    case (UICollectionView.elementKindSectionHeader, 0):
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LikeCell.likeHeader, for: indexPath) as! LikeReusableView

      return header

    case (UICollectionView.elementKindSectionHeader, 1):
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UploadCell.uploadHeader, for: indexPath) as! UploadReusableView

      return header

    default:
      return UICollectionReusableView()
    }

  }
}
// MARK: - 확장 / 컬렉션뷰 컴포지셔널 레이아웃
extension FavoritesViewController {

  // MARK: - 컴포지셔널 레이아웃 설정 - 리스트
  fileprivate func setupCompositionalLayoutList() -> UICollectionViewLayout {
    // 컴포지셔널 레이아웃 생성
    let layout = UICollectionViewCompositionalLayout {
      // 만들게 되면 튜플 형식으로 값이 들어옴
      // 반환 하는 것은 NSCollectionLayoutSection(콜렉션 레이아웃 섹션)을 반환해야함
      (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in


      /// 아이템사이즈 - 그룹의 가로크기의 1/5, 최소크기 50
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/5), heightDimension: .fractionalWidth(1/5))
      /// 아이템사이즈로 아이템 만들기
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      /// 아이템간의 여백 설정
      item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
      /// 그룹사이즈 - 컬렉션뷰 가로길의의 1, 아이템사이즈의 높이크기(50)
      let groupSize = NSCollectionLayoutSize( widthDimension: .fractionalWidth(1.3), heightDimension: .estimated(80))
      /// 그룹사이즈로 그룹만들기
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      /// 헤더사이즈 -
      let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(100))
      /// 헤더만들기
      let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

      /// 섹션
      let section = NSCollectionLayoutSection(group: group)
      /// 섹션에 헤더, 풋터 등록
      section.boundarySupplementaryItems = [header]
      section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0)
      section.orthogonalScrollingBehavior = .continuous
      /// 반환
      return section
    }

    return layout
  }



}
