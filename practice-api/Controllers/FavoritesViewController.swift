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

  lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: FavoritesViewController.getCollectionViewCompositionalLayout()).then {
    // 스크롤 여부
    $0.isScrollEnabled = true
    // 가로 스크롤바 표시 여부
    $0.showsHorizontalScrollIndicator = false
    // 세로 스크롤바 표시 여부
    $0.showsVerticalScrollIndicator = true
    // contentInset은 컨텐츠에 상하좌우 여백
    $0.contentInset = .zero
    $0.backgroundColor = .white
    // 서브뷰들이 스크롤뷰의 bounds에 가둬질 수 있는 지를 판단
    $0.clipsToBounds = true
  }

  // 컬렉션뷰가 테이블뷰와의 다른점
  private let flowLayout = UICollectionViewFlowLayout()

  var likeArray: CatsData = []

  // MARK: - 뷰디드로드
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupCollectionViewSnp()
    setupNavbar()
  }
  // MARK: - 컬렉션뷰 셋업 메서드
  private func setupCollectionView() {
    collectionView.dataSource = self
    collectionView.delegate = self
    // 셀 셀프사이징
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    // 좋아요 헤더 셀 등록
    collectionView.register(UINib(nibName: LikeCell.likeHeader, bundle: nil), forCellWithReuseIdentifier: LikeCell.likeHeader)
    // 좋아요 목록 셀 등록
    collectionView.register(UINib(nibName: LikeCell.likeCellID, bundle: nil), forCellWithReuseIdentifier: LikeCell.likeCellID)
    // 업로드 헤더 셀 등록
    collectionView.register(UINib(nibName: UploadCell.uploadHeader, bundle: nil), forCellWithReuseIdentifier: UploadCell.uploadHeader)
    // 업로드 목록 셀 등록
    collectionView.register(UINib(nibName: UploadCell.uploadCellID, bundle: nil), forCellWithReuseIdentifier: UploadCell.uploadCellID)
  }

  // MARK: - 컬렉션뷰 스냅킷 메서드
  private func setupCollectionViewSnp() {
    self.view.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.left.equalToSuperview()
      $0.right.equalToSuperview()
      $0.bottom.equalToSuperview()
    }

  }

  // MARK: - 네비게이션바 셋업 메서드
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

  // MARK: - 컴포지셔널 레이아웃
  static func getCollectionViewCompositionalLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout {
      // 만들게 되면 튜플 (키: 값, 키: 값) 의 묶음으로 들어옴 반환 하는 것은 NSCollectionLayoutSection 콜렉션 레이아웃 섹션을 반환해야함
      (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      switch sectionIndex {
      case 0:
        return FavoritesViewController.getMainCompostionalLayoutSection()
      case 1:
        return FavoritesViewController.getHorizentalCompositinalLayoutSection()
      case 2:
        return FavoritesViewController.getVerticalCompositionalLayoutSection()
      default:
        return nil
      }
    }
    return layout
  }




}

// MARK: - 확장 / 컬렉션뷰 데이터소스
extension FavoritesViewController: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 3
  }


  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }

  

}

// MARK: - 확장 / 컬렉션뷰 델리게이트
extension FavoritesViewController: UICollectionViewDelegate {

  //  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  //    <#code#>
  //  }
}

// MARK: - 컬렉션뷰 컴포지셔널 섹션 레이아웃 잡기
extension FavoritesViewController {
  // 메인섹션 레이아웃 잡기
  static func getMainCompostionalLayoutSection() -> NSCollectionLayoutSection {
    // 아이템사이즈 - 그룹의 가로크기의 1/5, 최소크기 50
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/6), heightDimension: .estimated(50))
    // 아이템사이즈로 아이템 만들기
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    // 아이템간의 여백 설정
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
    // 그룹사이즈 - 컬렉션뷰 가로길의의 1, 아이템사이즈의 높이크기(50)
    let groupSize = NSCollectionLayoutSize( widthDimension: .fractionalWidth(1.3), heightDimension: .estimated(80))
    // 그룹사이즈로 그룹만들기
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    // 헤더사이즈 -
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(65))
    // 헤더만들기
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: "mainHeader", alignment: .top)
    // 풋터사이즈 -
    let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
    // 풋터만들기
    let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: "mainFooter", alignment: .bottom)
    // 섹션
    let section = NSCollectionLayoutSection(group: group)
    // 섹션에 헤더, 풋터 등록
    section.boundarySupplementaryItems = [header,footer]
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    section.orthogonalScrollingBehavior = .continuous
    // 반환
    return section
  }
  // 호리젠탈 섹션 레이아웃 잡기
  static func getHorizentalCompositinalLayoutSection() -> NSCollectionLayoutSection {
    // 아이템사이즈 - 그룹 가로길이의 1/2, 그룹 세로길이의 1/1
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
    // 아이템사이즈로 아이템 만들기
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    // 그룹사이즈 - 컬렉션 뷰의 가로 길이의 1.15배, 컬렉션 뷰의 세로 길이의 1/3.8
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.15), heightDimension: .fractionalHeight(1.0/3.0))
    // 그룹사이즈로 그룹만들기
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    // 헤더사이즈 -
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
    // 헤더 만들기
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "horizentalHeader", alignment: .top)
    // 섹션
    let section = NSCollectionLayoutSection(group: group)
    // 섹션에 헤더 등록
    section.boundarySupplementaryItems = [header]
    // 섹션의 스크롤 설정
    section.orthogonalScrollingBehavior = .continuous
    // 섹션 반환
    return section
  }
  // 버티컬 섹션 레이아웃 잡기
  static func getVerticalCompositionalLayoutSection() -> NSCollectionLayoutSection {
    // 아이템사이즈 - 그룹 가로길이의 1/1, 그룹 세로길이의 1/4,
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(237))
    // 아이템사이즈로 아이템만들기
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    // 그룹사이즈 - 컬렉션뷰 가로길이의 1/1, 컬렉션뷰 세로길이의 1/3
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2))
    // 그룹사이즈로 그룹만들기
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    // 헤더
    // 섹션
    let section = NSCollectionLayoutSection(group: group)
    // 섹션의 스크롤 설정
    section.orthogonalScrollingBehavior = .continuous
    // 섹션반환
    return section
  }
}
