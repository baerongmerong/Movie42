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
    @IBOutlet weak var previewLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        // 검색 버튼이 눌렸을 때 검색 수행
        movieSearchVM.performSearch(query: searchTextField.text ?? "")
    }
    
    // MovieSearchViewModel 인스턴스 생성
    private let movieSearchVM = MovieSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        searchTextField.delegate = self
        
        // 초기데이터 로드
        setupReload()
        movieSearchVM.fetchData()
        
        // 검색 미리보기 라벨에 탭 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(previewLabelTapped))
        previewLabel.isUserInteractionEnabled = true
        previewLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setupReload() {
        // 화면업데이트가 필요할 때마다 reloadData호출
        movieSearchVM.updateMovie = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        // 미리보기 라벨 업데이트 클로저 설정
        movieSearchVM.updatePreviewLabel = { [weak self] in
            DispatchQueue.main.async {
                self?.updatePreviewLabel()
            }
        }
    }
    
    @objc func previewLabelTapped() {
        // 검색 미리보기 라벨 클릭시 검색 수행
        if let previewText = previewLabel.text {
            print("검색어 클릭 \(previewText)")
            movieSearchVM.performSearch(query: previewText)
        }
    }
    
    // 미리보기 라벨 업데이트 메서드
    func updatePreviewLabel() {
        let previewTitles = movieSearchVM.getPreviewTitles()
        let previewText = previewTitles.joined(separator: "\n")
        previewLabel.text = previewText
        
        // 미리보기 라벨 배경색 설정
        previewLabel.backgroundColor = UIColor.systemGray4
        adjustPreviewLabelHeight()
        print(previewTitles)
    }
    
    // 미리보기 라벨의 높이를 동적으로 조절
    private func adjustPreviewLabelHeight() {
        // 미리보기 라벨의 높이를 동적으로 조절
        let labelWidth = previewLabel.frame.width
        
        // numberOfLines를 0으로 설정하여 여러 줄을 허용
        previewLabel.numberOfLines = 0
        
        // sizeThatFits에서 constrainedToSize를 사용하여 최대 높이를 설정
        let maxSize = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = previewLabel.sizeThatFits(maxSize)
        
        previewLabel.frame.size = CGSize(width: labelWidth, height: labelSize.height)
    }
    
}

// MARK: - UISearchBarDelegate
extension MovieSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 검색어가 변경될 때마다 검색 미리보기 업데이트
        movieSearchVM.updatePreviewTitles(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 검색 버튼이 클릭되면 검색 수행
        performSearch()
    }
    
    private func performSearch() {
        // 검색 실행
        guard let searchText = searchTextField.text, !searchText.isEmpty else {
            // 검색어가 비어있으면 미리보기 타이틀 제거
            previewLabel.text = nil
            return
        }
        
        // 검색어가 비어있지 않으면 검색 수행
        movieSearchVM.performSearch(query: searchText)
        
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
        //print("MovieSearchVC movieSearchVM item : \(movie)")
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

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieSearchViewController: UICollectionViewDelegateFlowLayout {
    // 셀의 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width / 3 - 6.0 // 한 줄에 3개씩
        let cellHeight = cellWidth * 1.4 + 63.0 // 이미지 높이 + 라벨 높이
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    // 셀과 셀 사이의 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    // 셀이 표시될 때의 여백 설정 (상, 하, 좌, 우)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4.0, left: 1.0, bottom: 4.0, right: 1.0)
    }
}
