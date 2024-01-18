//
//  MovieScreenVC.swift
//  Movie42_MVVM
//
//  Created by Bae on 1/18/24.
//

import Foundation
import UIKit

class ListCell: UICollectionViewCell {
    @IBOutlet weak var movieCover: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
}

class MovieScreenViewController: UIViewController {
    
    let viewModel = MovieViewModel()
       
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MovieScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.listCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ListCell else {
            return UICollectionViewCell()
        }
        
        let movie = viewModel.getTheMovie(at: indexPath.item)
//        cell.updateView(info: movie)
    
        return cell
    }
}

extension MovieScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "show", sender: indexPath.item)
    }
}

//extension MovieScreenViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionVoew: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemSpacing: CGFloat = 20
//        let textAreaHeight: CGFloat = 25
//
//        let width: CGFloat =
//        let height: CGFloat =
//
//        return CGSize(width: width, height: height)
//
//    }
//}
