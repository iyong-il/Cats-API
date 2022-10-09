//
//  ViewController.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//

import UIKit
import SnapKit
import Then

final class ViewController: UIViewController {

  private let tableView = UITableView()
  private let refreshControl = UIRefreshControl()

  private var networkManager = NetworkingManager.shared
  private var catsArrays: CatsData = []

  var pages = 1

// MARK: - 뷰디드로드
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDatas()
    setupTableView()
    setupNavbar()
    setupRefresh()
  }

// MARK: - 데이터 셋업 메서드
  private func setupDatas() {
    networkManager.fetchData(page: 1) { result in
      switch result {
      case .success(let catsData):
        self.catsArrays = catsData

        DispatchQueue.main.async {
          self.tableView.reloadData()
        }

      case .failure(let error):
        print(error.localizedDescription)
      }

    }

  }

// MARK: - 테이블뷰 셋업 메서드
  private func setupTableView() {

    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorStyle = .none
    tableView.register(UINib(nibName: Cell.tableCellID, bundle: nil), forCellReuseIdentifier: Cell.tableCellID)
    self.view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.left.equalToSuperview()
      $0.right.equalToSuperview()
      $0.bottom.equalToSuperview()
    }

  }
  
// MARK: - 네비게이션바 셋업 메서드
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

// MARK: - 리프레시 메서드
  private func setupRefresh() {
    refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    tableView.refreshControl = refreshControl
  }

  // MARK: - 셀렉터 / 리프레시
  @objc func refresh(_ sender:UIRefreshControl) {
    pages = 1
    setupDatas()
    self.refreshControl.endRefreshing()
  }








}

// MARK: - 확장 / 테이블뷰 데이터소스
extension ViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return catsArrays.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: Cell.tableCellID, for: indexPath) as! CatsCell
    cell.cats = catsArrays[indexPath.row]

    cell.selectionStyle = .none
    return cell
  }

}

// MARK: - 확장 / 테이블뷰 델리게이트
extension ViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
    return UITableView.automaticDimension
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print(#fileID, #function, #line, "- 페이지네이션")

    // 화면에 보이는 좌측상단
    let contentOffsetY = scrollView.contentOffset.y
    // 모든 테이블뷰의 높이
    let tableViewContentSizeY = self.tableView.contentSize.height
    // 페이지네이션을 하고싶은 y좌표는 테이블뷰의 0.2지점
    let paginationY = tableViewContentSizeY * 0.2

    if contentOffsetY > tableViewContentSizeY - paginationY {
      pages += 1
      networkManager.fetchData(page: pages) { result in
        switch result {
        case .success(let catsData):
          DispatchQueue.global().async {
            self.catsArrays.append(contentsOf: catsData)

            DispatchQueue.main.async {
              self.tableView.reloadData()
            }
          }

        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }

  }

}
