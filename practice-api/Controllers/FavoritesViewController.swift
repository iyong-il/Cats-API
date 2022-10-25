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

  // MARK: - 속성
  // 컬렉션뷰
  lazy var collectionView: UICollectionView = {
    let view = UICollectionView(frame: .zero, collectionViewLayout: FavoritesViewController.setupCompositionalLayout())
    view.isScrollEnabled = true
    view.showsHorizontalScrollIndicator = false
    view.showsVerticalScrollIndicator = false
    view.contentInset = .zero
    view.backgroundColor = .white
    view.clipsToBounds = true

    return view
  }()


  // MARK: - 라이프사이클
  // 뷰가 나타나기전 호출됨 - 반복호출
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    collectionView.reloadData()
  }

  // 뷰디드로드
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavbar()
    setupCollectionView()
  }

  // MARK: - 메서드
  // 컬렉션뷰 셋업
  private func setupCollectionView() {
    self.view.addSubview(collectionView)

    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.dataSource = self

    // 좋아요 쎌 등록
    collectionView.register(UINib(nibName: String(describing: LikeCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: Like.likeCellID)

    // 업로드 쎌 등록
    collectionView.register(UINib(nibName: String(describing: UploadCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: Upload.uploadCellID)

    // 좋아요 헤더 등록
    collectionView.register(UINib(nibName: String(describing: LikeReusableView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Like.likeHeader)

    // 업로드 헤더 등록
    collectionView.register(UINib(nibName: String(describing: UploadReusableView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Upload.uploadHeader)

  }

  // 네비게이션바 셋업
  private func setupNavbar() {
    self.title = "목록"

    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .white
    navigationController?.navigationBar.tintColor = .systemBlue
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance

  }

  // 컴포지셔널 레이아웃 생성 - 타입메서드
  static func setupCompositionalLayout() -> UICollectionViewLayout {

    let layout = UICollectionViewCompositionalLayout {
      (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

      switch sectionIndex {
      case 0:
        return FavoritesViewController.setupCompositionalLayoutHorizental()

      case 1:
        return FavoritesViewController.setupCompositionalLayoutHorizental()

      default:
        return nil

      }
    }
    return layout
  }

}

// MARK: - 확장 / 컬렉션뷰 데이터소스
extension FavoritesViewController: UICollectionViewDataSource {

  // 섹션의 개수
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }

  // 섹션의 아이템 개수
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    switch section {

    case 0:
      return 2

    case 1:
      return 3

    default:
      return 0

    }
  }

  // 셀
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let sectionIndex = indexPath.section

    switch sectionIndex {
    case 0:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Like.likeCellID, for: indexPath) as! LikeCollectionViewCell
      // 버튼 클로저 - 좋아요 삭제 (나중에 델리겟으로 변경 예정)
      cell.likeDeleteButtonPressed = { [weak self] (sender) in
        guard let self = self else { return }

      }
      return cell

    case 1:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Upload.uploadCellID, for: indexPath) as! UploadCollectionViewCell
      // 버튼 클로저 - 업로드 삭제 (나중에 델리겟으로 변경 예정)
      cell.uploadDeleteButtonPressed = { [weak self] (sender) in
        guard let self = self else { return }

      }
      return cell

    default:
      return UICollectionViewCell()
    }

  }

  // 헤더
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

    let sectionIndex = indexPath.section

    switch (kind, sectionIndex) {

      // 좋아요헤더
    case (UICollectionView.elementKindSectionHeader, 0):
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Like.likeHeader, for: indexPath) as! LikeReusableView

      return header

      // 업로드 헤더
    case (UICollectionView.elementKindSectionHeader, 1):
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Upload.uploadHeader, for: indexPath) as! UploadReusableView

      return header

    default:
      return UICollectionReusableView()
    }
  }


}

// MARK: - 확장 / 컬렉션뷰 컴포지셔널 레이아웃
extension FavoritesViewController {

  static func setupCompositionalLayoutHorizental()  -> NSCollectionLayoutSection {

    // 아이템사이즈
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .absolute(120))
    // 아이템 만들기
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    // 아이템간의 여백 설정
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)


    // 그룹사이즈
    let groupSize = NSCollectionLayoutSize( widthDimension: .fractionalWidth(1.0), heightDimension: itemSize.heightDimension)
    // 그룹만들기
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])


    // 헤더사이즈
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
    // 헤더만들기
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)


    // 섹션
    let section = NSCollectionLayoutSection(group: group)

    // 섹션에 헤더  등록
    section.boundarySupplementaryItems = [header]
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 60, trailing: 0)

    // 오른쪽으로 스크롤 가능
    section.orthogonalScrollingBehavior = .continuous

    return section
  }

}
