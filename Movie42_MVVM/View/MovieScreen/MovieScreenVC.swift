import Foundation
import UIKit

class MovieScreenViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let movieScreenVM = MovieScreenVM()
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self

        
        movieScreenVM.fetchData()
        movieScreenVM.fetchData2()
        movieScreenVM.fetchData3()
        movieScreenVM.fetchData4()

    }
}

extension MovieScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return movieScreenVM.itemsCount()
        } else if section == 1 {
            return movieScreenVM.itemsCount()
        }
        else if section == 2{
            return movieScreenVM.itemsCount()
        }
        else {
            return movieScreenVM.itemsCount()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ScreenCollectionViewCell
        if indexPath.section == 0 {
            let movie = movieScreenVM.item(at: indexPath.item)
            cell.configure(with: movie)
        } else if indexPath.section == 1 {
            let movie = movieScreenVM.item(at: indexPath.item)
            cell.configure(with: movie)
        } else if indexPath.section == 2 {
            let movie = movieScreenVM.item(at: indexPath.item)
            cell.configure(with: movie)
        }
        else {
            let movie = movieScreenVM.item(at: indexPath.item)
            cell.configure(with: movie)
        }
        return cell
    }
}
//func createFlowLayout() -> UICollectionViewFlowLayout {
//    
//    let flowlayout = UICollectionViewFlowLayout()
//    flowlayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//    flowlayout.minimumLineSpacing = 10
//    flowlayout.minimumInteritemSpacing = 10
//    flowlayout.itemSize = CGSize(width: 10, height: 10)
//    flowlayout.scrollDirection = .horizontal
//    
//    return flowlayout
//}

//extension MovieScreenViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellWidth = collectionView.frame.width - 80 // 한 줄에 1개씩
//        let cellHeight = view.frame.height
//        return CGSize(width: cellWidth, height: cellHeight)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//}
