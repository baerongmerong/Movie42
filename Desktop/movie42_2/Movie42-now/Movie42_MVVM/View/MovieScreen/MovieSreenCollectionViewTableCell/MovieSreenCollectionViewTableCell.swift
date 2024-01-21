//
//  MovieSreenCollectionViewTableCell.swift
//  Movie42_MVVM
//
//  Created by mirae on 1/21/24.
//

import UIKit

// MovieSreenCollectionViewTableCell에서 델리게이트 프로토콜 정의
protocol MovieSreenCollectionViewTableCellDelegate: AnyObject {
    func didSelect(movie: Movie, category: MovieCategory)
}

class MovieSreenCollectionViewTableCell: UITableViewCell {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    weak var delegate: MovieSreenCollectionViewTableCellDelegate?
    private var category: MovieCategory?
    private var movies: [Movie] = []
    private let movieScreenVM = MovieScreenViewModel()

    static let identifier = "MovieSreenCollectionViewTableCell"

    static func nib() -> UINib {
        return UINib(nibName: "MovieSreenCollectionViewTableCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(MovieSreenCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieSreenCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func configure(category: MovieCategory, movies: [Movie]) {
        self.category = category
        self.movies = movies
        collectionView.reloadData() // collectionView를 새로고침하여 데이터를 반영
    }
}

extension MovieSreenCollectionViewTableCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
        return UIEdgeInsets(top: 4.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
}

extension MovieSreenCollectionViewTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSreenCollectionViewCell.identifier, for: indexPath) as! MovieSreenCollectionViewCell
        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedMovie = movieScreenVM.item(at: indexPath.item)
//        showDetailView(with: selectedMovie)
//    }
//    
//    func showDetailView(with movie: Movie?) {
//        guard let movie = movie else {
//            return
//        }
//        
//        let storyboard = UIStoryboard(name: "MovieDetailView", bundle: nil)
//        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
//            detailViewController.selectedMovie = movie
//            detailViewController.modalPresentationStyle = .automatic
//            present(detailViewController, animated: false, completion: nil)
//        }
//    }
}
