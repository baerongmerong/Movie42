import Foundation
import UIKit

class MovieScreenViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let movieScreenVM = MovieScreenVM()
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        movieScreenVM.fetchData()
        
    }
}

extension MovieScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieScreenVM.itemsCount()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ScreenCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movie = movieScreenVM.item(at: indexPath.item)
        cell.configure(with: movie)
        
        return cell
    }
}

//extension MovieScreenViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "show", sender: indexPath.item)
//    }
//}
