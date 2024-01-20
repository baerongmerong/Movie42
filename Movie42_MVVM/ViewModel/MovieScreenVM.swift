import Foundation

class MovieScreenVM {
    private let movieService = MovieService()

    // 화면 업데이트를 위한 클로저 타입 프로퍼티
    var updateMovie: (() -> Void)?

    // 각 카테고리에 대한 영화 목록을 저장하는 배열
    private var nowPlayingMovies: [Movie] = []
    private var popularMovies: [Movie] = []
    private var topRatedMovies: [Movie] = []
    private var upcomingMovies: [Movie] = []

    // 전체 영화 목록을 업데이트하는 메서드
    private func updateAllMovies() {
        allMovies = nowPlayingMovies + popularMovies + topRatedMovies + upcomingMovies
    }

    // 전체 영화 목록을 저장하는 배열
    private var allMovies: [Movie] = [] {
        didSet {
            // 전체 영화 목록이 업데이트되면 화면을 업데이트하는 클로저 호출
            updateMovie?()
        }
    }

    // 현재 화면에 표시할 데이터를 저장하는 배열
    private var currentData: [Movie] = [] {
        didSet {
            // 현재 데이터가 업데이트되면 화면을 업데이트하는 클로저 호출
            updateMovie?()
        }
    }

    // 초기화
    init() {
        // 페이지 진입 NowPlay 영화 데이터 불러옴
        fetchData(for: .nowPlaying) {}
        fetchData(for: .popular) {}
        fetchData(for: .topRated) {}
        fetchData(for: .upcoming) {}
    }

    // 각 카테고리에 대한 데이터를 가져오는 메서드
    func fetchData(for category: MovieCategory, completion: @escaping () -> Void) {
        movieService.fetchMovies(for: category) { [weak self] result in
            switch result {
            case .success(let movieResponse):
                // 각 카테고리에 따라 영화 목록을 업데이트
                switch category {
                case .nowPlaying:
                    self?.nowPlayingMovies = movieResponse.results
                case .popular:
                    self?.popularMovies = movieResponse.results
                case .topRated:
                    self?.topRatedMovies = movieResponse.results
                case .upcoming:
                    self?.upcomingMovies = movieResponse.results
                }
                // 전체 영화 목록 업데이트
                self?.updateAllMovies()
                // 초기에는 상영중인 데이터를 화면에 표시
                self?.currentData = self?.allMovies ?? []
            case .failure(let error):
                // 에러 처리
                print("Error MovieScreenVM fetchData: \(error.localizedDescription)")
            }

            completion()
        }
    }

    // 현재 데이터의 개수를 반환
    func itemsCount(for section: MovieCategory) -> Int {
            switch section {
            case .nowPlaying:
                return nowPlayingMovies.count
            case .popular:
                return popularMovies.count
            case .topRated:
                return topRatedMovies.count
            case .upcoming:
                return upcomingMovies.count
            }
        }

    // 특정 인덱스의 값을 반환
    func item(at index: Int, for section: MovieCategory) -> Movie {
        switch section {
        case .nowPlaying:
            return nowPlayingMovies[index]
        case .popular:
            return popularMovies[index]
        case .topRated:
            return topRatedMovies[index]
        case .upcoming:
            return upcomingMovies[index]
        }
    }
}
