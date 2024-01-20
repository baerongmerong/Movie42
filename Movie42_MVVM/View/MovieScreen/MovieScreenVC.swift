import Foundation
import UIKit

class MovieScreenViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let movieScreenVM = MovieScreenVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupReload()
        movieScreenVM.fetchData(for: .nowPlaying){}
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

extension MovieScreenViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YourCellIdentifier", for: indexPath) as! YourCustomCell

        // 각 섹션에 따른 데이터 설정
        switch indexPath.section {
        case 0:
            cell.configure(with: movieScreenVM.item(at: indexPath.item, for: .nowPlaying))
        case 1:
            cell.configure(with: movieScreenVM.item(at: indexPath.item, for: .popular))
        case 2:
            cell.configure(with: movieScreenVM.item(at: indexPath.item, for: .topRated))
        case 3:
            cell.configure(with: movieScreenVM.item(at: indexPath.item, for: .upcoming))
        default:
            break
        }

        return cell
    }
}
