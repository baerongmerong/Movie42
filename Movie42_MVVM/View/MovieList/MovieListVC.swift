//
//  MovieListVC.swift
//  Movie42_MVVM
//
//  Created by Bae on 1/17/24.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var listBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var mypageBtn: UIButton!
    
    @IBOutlet weak var contentView: UIView!
//    
//    var MovieListScreenVC: MovieListScreenViewController!
//    var MovieSearchVC: MovieSearchViewController!
//    var MyPageVC: MyPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        MovieListScreenVC = UIStoryboard(name: "영화목록", bundle: nil).instantiateViewController(withIdentifier: "MovieListScreenViewController")as? MovieListScreenViewController
//        MovieSearchVC = UIStoryboard(name: "영화검색", bundle: nil).instantiateViewController(withIdentifier: "MovieSearchViewController")as? MovieSearchViewController
//        MypageVC = UIStoryboard(name: "마이페이지", bundle: nil).instantiateViewController(withIdentifier: "MyPageViewController")as? MyPageViewController
//        
//        MovieScreen.MovieListVC = self
//        MovieSearchVC.MovieListVC = self
//        MyPageVC.MovieListVC = self
//        
//        contentView.addSubview(MovieListVC.view)
//        
//        initBtn()
        listBtn.layer.backgroundColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1).cgColor
        listBtn.tintColor = .white
    }
}

//    override func viewWillAppear(_ animaed: Bool) {
//    
//}
//
//extension MovieListViewController: UITableViewDataSource {
//
//}
//extension MovieListViewController {
//    @IBAction func tapTopButton(_ sender: UIButton) {
//        initBtn()
//        sender.layer.backgroundColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1).cgColor
//        sender.tintColor = .white
//        
//        MovieListScreenVC.removeFromParent()
//        MovieSearchVC.removeFromParent()
//        MypagetVC.removeFromParent()
//        switch sender.titleLabel?.text {
//        case "영화목록":
//            contentView.addSubview(MovieListScreenVC.view)
//        case "영화검색":
//            contentView.addSubview(MovieSearchVC.view)
//        case "마이페이지":
//            contentView.addSubview(MypageVC.view)
//        default:
//            return
//        }
//    }
//}

//extension MovieListViewController {
//    private func initBtn() {
//        ListBtn.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
//        ListBtn.layer.borderColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1).cgColor
//        ListBtn.layer.cornerRadius = 16
//        ListBtn.layer.borderWidth = 1
//        ListBtn.clipsToBounds = true
//        ListBtn.tintColor = .black
//        
//        SearchBtn.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
//        SearchBtn.layer.borderColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1).cgColor
//        SearchBtn.layer.cornerRadius = 16
//        SearchBtn.layer.borderWidth = 1
//        SearchBtn.clipsToBounds = true
//        SearchBtn.tintColor = .black
//        
//        MypageBtn.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
//        MypageBtn.layer.borderColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1).cgColor
//        MypageBtn.layer.cornerRadius = 16
//        MypageBtn.layer.borderWidth = 1
//        MypageBtn.clipsToBounds = true
//        MypageBtn.tintColor = .black
//    }
//}
