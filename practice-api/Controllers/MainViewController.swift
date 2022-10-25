//
//  ViewController.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//

import UIKit
import SnapKit
import Then
import Alamofire

final class MainViewController: UIViewController {

  // MARK: - 속성
  private let tableView = UITableView()

  private let refreshControl = UIRefreshControl().then {
    $0.attributedTitle = NSAttributedString(string: "다른 고양이들을 불러올게요!", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemPurple])
    $0.tintColor = .systemPurple
    $0.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
  }

  private var networkManager = NetworkingManager.shared
  private var catsArrays: [Cats] = []

  private var pages = 1

  // 이미 만들어진 셀들의 높이 값을 저장
  private var cellHeight: [IndexPath: CGFloat] = [:]

  // MARK: - 라이프사이클
  // 뷰디드로드
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDatas()
    setupTableView()
    setupNavbar()

  }

  // MARK: - 메서드
  // 데이터 셋업
  private func setupDatas() {
    API.setupAFDatas(page: pages) { result in
      switch result {
      case .success(let data):
        self.catsArrays.append(contentsOf: data)

        DispatchQueue.main.async {
          self.tableView.reloadData()
        }

      case .failure(let error):
        print(error.localizedDescription)
      }
    }

  }

  

  // 테이블뷰 셋업
  private func setupTableView() {
    self.view.addSubview(tableView)

    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    tableView.dataSource = self
    tableView.delegate = self

    tableView.showsVerticalScrollIndicator = false
    tableView.separatorStyle = .none
    tableView.register(UINib(nibName: String(describing: CatsTableViewCell.self), bundle: nil), forCellReuseIdentifier: CatsCell.catCellID)

    tableView.refreshControl = refreshControl
  }
  
  // 네비게이션바 셋업
  private func setupNavbar() {
    self.title = "고양이들"

    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .white
    navigationController?.navigationBar.tintColor = .systemBlue
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
  }


  // MARK: - 셀렉터
  // 리프레시
  @objc func refresh(_ sender:UIRefreshControl) {
    setupDatas()
    self.refreshControl.endRefreshing()
  }








}

// MARK: - 확장 / 테이블뷰 데이터소스
extension MainViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return catsArrays.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CatsCell.catCellID, for: indexPath) as! CatsTableViewCell
    cell.cats = catsArrays[indexPath.row]


    cell.selectionStyle = .none
    return cell
  }

}

// MARK: - 확장 / 테이블뷰 델리게이트
extension MainViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    // 셀의 데이터 세팅이 완료 된 후 실제 높이 값
    cellHeight[indexPath] = cell.frame.size.height
  }

//  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//    // 이미 만들어진 셀 높이가 없다면 무조건 360
//    // 페이징 시 화면이 튀는것을 방지하기 위해 높이를 고정시키는 것
//    return cellHeight[indexPath] ?? 360
//  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print(#fileID, #function, #line, "- 페이징")

    // 화면에 보이는 좌측상단
    let contentOffsetY = scrollView.contentOffset.y
    // 모든 테이블뷰의 높이
    let tableViewContentSizeY = self.tableView.contentSize.height
    // 페이지네이션을 하고싶은 y좌표는 테이블뷰의 0.2지점
    let paginationY = tableViewContentSizeY * 0.2

    if contentOffsetY > tableViewContentSizeY - paginationY {
      // 기존 데이터에 append
      pages += 1
      setupDatas()
      // 튀지는 않는데 좀 어색한 느낌이 있다. 다시 해봐야 할 부분
    }

  }

}
