//
//  MovieScreenViewController.swift
//  Movie42_MVVM
//
//  Created by mirae on 1/21/24.
//
import Foundation
import UIKit

class MovieScreenViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    private let movieScreenVM = MovieScreenViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupViewModel()
        fetchDataForAllCategories()
        
        tableView.separatorStyle = .none
    }

    private func setupTableView() {
        tableView.register(MovieSreenCollectionViewTableCell.nib(), forCellReuseIdentifier: MovieSreenCollectionViewTableCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupViewModel() {
        movieScreenVM.updateMovie = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func fetchDataForAllCategories() {
        movieScreenVM.fetchData(for: .nowPlaying)
        movieScreenVM.fetchData(for: .popular)
        movieScreenVM.fetchData(for: .topRated)
        movieScreenVM.fetchData(for: .upcoming)
    }
    
    
//    func didSelect(movie: Movie, category: MovieCategory) {
//        let storyboard = UIStoryboard(name: "MovieDetailView", bundle: nil)
//        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
//            detailViewController.selectedMovie = movie
//            detailViewController.modalPresentationStyle = .automatic
//            present(detailViewController, animated: false, completion: nil)
//        }
//    }
}

extension MovieScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // 카테고리별로 섹션을 나눔
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 각 섹션에 대한 영화 아이템 개수 반환
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieSreenCollectionViewTableCell.identifier, for: indexPath) as! MovieSreenCollectionViewTableCell
        let category = getCategory(for: indexPath.section)
        if let movies = movieScreenVM.movies(for: category) {
            cell.configure(category: category, movies: movies)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

    private func getCategory(for section: Int) -> MovieCategory {
        // 섹션에 대응하는 카테고리를 반환
        switch section {
        case 0:
            return .nowPlaying
        case 1:
            return .popular
        case 2:
            return .topRated
        case 3:
            return .upcoming
        default:
            fatalError("Invalid section")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0 // 헤더의 높이를 원하는 값으로 설정
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        //headerView.backgroundColor = .lightGray
        
        let label = UILabel()
        label.text = "\(getCategory(for: section))"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.frame = CGRect(x: 10, y: 0, width: tableView.bounds.size.width - 16, height: 30)
        headerView.addSubview(label)
        
        return headerView
    }
    
    
}
