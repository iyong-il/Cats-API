//
//  FavoritesViewController.swift
//  practice-api
//
//  Created by 이용일(Rodi) on 2022/10/09.
//

import UIKit

final class FavoritesViewController: UIViewController {


  
// MARK: - 뷰디드로드
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavbar()
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






}
