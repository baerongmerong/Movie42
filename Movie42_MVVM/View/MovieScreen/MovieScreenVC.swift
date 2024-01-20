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

extension MovieScreenViewController: UICollectionViewDataSource {

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ScreenCollectionViewCell

        // 각 섹션에 따른 데이터 설정
        switch indexPath.section {
        case 0:
            let movie = movieScreenVM.item(at: indexPath.item)
            cell.configure(with: movie)
        case 1:
            let movie = movieScreenVM.item(at: indexPath.item)
            cell.configure(with: movie)
        case 2:
            let movie = movieScreenVM.item(at: indexPath.item)
            cell.configure(with: movie)
        case 3:
            let movie = movieScreenVM.item(at: indexPath.item)
            cell.configure(with: movie)
        default:
            break
        }

        return cell
    }
}

//extension MovieScreenViewController: UICollectionViewDelegateFlowLayout {
//
//    // 각 섹션의 inset을 설정하여 좌에서 우로 슬라이딩되도록 함
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let edgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
//        return edgeInsets
//    }
//
//    // 각 섹션의 크기를 설정하여 좌에서 우로 슬라이딩되도록 함
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let collectionViewWidth = collectionView.bounds.width
//        let itemWidth = collectionViewWidth - 30 // 좌우 여백 15씩
//        let itemHeight = collectionView.bounds.height - 20 // 상하 여백 10씩
//        return CGSize(width: itemWidth, height: itemHeight)
//    }
//
//    // 각 섹션 간의 최소 간격을 설정하여 좌에서 우로 슬라이딩되도록 함
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 15
//    }
//}
