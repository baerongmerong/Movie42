//
//  MovieSearchVC.swift
//  Movie42_MVVM
//
//  Created by Bae on 1/17/24.
//

import Foundation
import UIKit

class MovieSearchViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UISearchBar!
    
    // MovieSearchViewModel 인스턴스 생성
    private let movieSearchVM = MovieSearchVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 초기데이터 로드
        setupReload()
        movieSearchVM.fetchData()
        
        // 콜렉션뷰의 데이터 소스 및 델리게이트 설정
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupReload() {
        // 화면업데이트가 필요할 때마다 reloadData호출
        movieSearchVM.updateMovie = { [weak self] in
            print("Update Movie Data")
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UISearchBarDelegate
extension MovieSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 검색어가 변경될 때마다 검색 수행
        movieSearchVM.performSearch(query: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 텍스트 변경시
        let updatedText = (searchBar.text as NSString?)?.replacingCharacters(in: range, with: text) ?? ""
        movieSearchVM.performSearch(query: updatedText)
        return true
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MovieSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 컬렉션 뷰 셀 설정
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {
            fatalError("Failed to dequeue MovieCollectionViewCell")
        }
        // 특정 인덱스의 아이템을 가져와 셀에 설정
        let movie = movieSearchVM.item(at: indexPath.item)
        print("MovieSearchVC movieSearchVM item : \(movie)")
        cell.configure(with: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieSearchVM.itemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 셀을 선택했을 때의 동작
        let selectedMovie = movieSearchVM.item(at: indexPath.item)
        // 상세 페이지로 이동하거나 다른 동작 수행
        
    }
    
    
}
