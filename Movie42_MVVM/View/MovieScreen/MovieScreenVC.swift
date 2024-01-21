import Foundation
import UIKit

class MovieScreenViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let movieScreenVM = MovieScreenVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupReload()
        movieScreenVM.fetchData(for: .nowPlaying) {}
        movieScreenVM.fetchData(for: .popular) {}
        movieScreenVM.fetchData(for: .topRated) {}
        movieScreenVM.fetchData(for: .upcoming) {}
        
    }
    
    private func setupReload() {
        movieScreenVM.updateMovie = {
            [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                
            }
        }
    }
}

extension MovieScreenViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! CollectionReusableView

            // Set the title based on the section
            switch indexPath.section {
            case 0:
                header.titleLabel.text = "Now Playing"
            case 1:
                header.titleLabel.text = "Popular"
            case 2:
                header.titleLabel.text = "Top Rated"
            case 3:
                header.titleLabel.text = "Upcoming"
            default:
                break
            }

            return header
        } else {
            return UICollectionReusableView()
        }
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 각 섹션에 따른 데이터 개수 반환
        switch section {
        case 0:
            return movieScreenVM.itemsCount(for: .nowPlaying)
        case 1:
            return movieScreenVM.itemsCount(for: .popular)
        case 2:
            return movieScreenVM.itemsCount(for: .topRated)
        case 3:
            return movieScreenVM.itemsCount(for: .upcoming)
        default:
            return 0
        }
    }
    


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ScreenCollectionViewCell

        // 각 섹션에 따른 데이터 설정
        switch indexPath.section {
        case 0:
            let movie = movieScreenVM.item(at: indexPath.item, for: .nowPlaying)
            cell.configure(with: movie)
            print(1)
        case 1:
            let movie = movieScreenVM.item(at: indexPath.item, for: .popular)
            cell.configure(with: movie)
            print(2)
        case 2:
            let movie = movieScreenVM.item(at: indexPath.item, for: .topRated)
            cell.configure(with: movie)
            print(3)
        case 3:
            let movie = movieScreenVM.item(at: indexPath.item, for: .upcoming)
            cell.configure(with: movie)
            print(4)
        default:
            break
        }

        return cell
    }
}

extension MovieScreenViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieCategory: MovieCategory
        switch indexPath.section {
        case 0:
            movieCategory = .nowPlaying
        case 1:
            movieCategory = .popular
        case 2:
            movieCategory = .topRated
        case 3:
            movieCategory = .upcoming
        default:
            return
        }

        let selectedMovie = movieScreenVM.item(at: indexPath.item, for: movieCategory)

        showDetailView(with: selectedMovie)
    }

    func showDetailView(with movie: Movie) {
        let storyboard = UIStoryboard(name: "MovieDetailView", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            // MovieDetailViewController의 프로퍼티에 직접 할당
            detailViewController.selectedMovie = movie
            
            // 화면을 modal로 표시
            detailViewController.modalPresentationStyle = .automatic
            present(detailViewController, animated: false, completion: nil)
        }
    }
}

