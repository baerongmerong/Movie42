//
//  MovieSearchVM.swift
//  Movie42_MVVM
//
//  Created by Bae on 1/17/24.
//

import Foundation

class MovieSearchViewModel {
    private let movieService = MovieService()
    
    // 화면 업데이트를 위한 클로저타입 프로퍼티
    var updateMovie: (() -> Void)?
    
    // 검색 미리보기 업데이트를 위한 클로저타입 프로퍼티
    var updatePreviewLabel: (() -> Void)?
    
    // 전체 영화목록을 저장하는 배열
    internal var allMovies: [Movie] = [] {
        didSet {
            // 전체 영화목록이 업데이트되면 화면을 업데이트하는 클로저 호출
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
    
    // 현재 검색어에 대한 미리보기 텍스트를 저장하는 배열
    private var previewTitles: [String] = [] {
        didSet {
            // 미리보기 텍스트가 업데이트되면 클로저 호출
            updatePreviewLabel?()
        }
    }
    
    // 초기화
    init() {
        // 페이지 진입 NowPlay 영화데이터 불러옴
        fetchData()
    }
    
    // nowPlaying을 불러오는 API 호출
    func fetchData() {
        movieService.fetchMovies(for: .nowPlaying) { [weak self] result in
            switch result {
            case .success(let movieResponse):
                // 전체 영화 목록을 저장
                self?.allMovies = movieResponse.results
                // 초기에는 상영중인 데이터를 화면에 표시
                self?.currentData = movieResponse.results
                //print(movieResponse.results)
            case .failure(let error):
                // 에러 처리
                print("Error MovieSearchVM fetchData: \(error.localizedDescription)")
            }
        }
    }

    // 검색 메서드
    func performSearch(query: String){
        if query.isEmpty {
            // 검색어가 비어있으면 상영중인 기본 데이터를 보여줌
            currentData = allMovies
        } else {
            // 검색어에 해당하는 결과를 필터링하여 저장 (lowercased로 소문자 변환하여 필터링)
            currentData = allMovies.filter {
                $0.title.lowercased().contains(query.lowercased())
            }
        }
        // 검색 미리보기 라벨 업데이트
        updatePreviewTitles(with: query)
    }
    
    // 현재 검색어에 대한 미리보기 텍스트를 가져오는 메서드
    func getPreviewTitles() -> [String] {
        return previewTitles
    }
    
    // 검색 미리보기 텍스트 업데이트
    func updatePreviewTitles(with searchText: String) {
        if searchText.isEmpty {
            // 검색어가 비어있다면 미리보기 텍스트 제거
            previewTitles = []
        } else {
            // 검색어가 있을 경우 해당 검색어에 대한 미리보기 텍스트 생성 및 업데이트
            previewTitles = generatePreviewText(for: searchText)
        }
        // 미리보기 라벨 업데이트 클로저 호출
        updatePreviewLabel?()
    }
    
    // 검색어에 대한 미리보기 텍스트를 생성하는 메서드
    private func generatePreviewText(for searchText: String) -> [String] {
        // 여기에서 검색어에 대한 미리보기 텍스트를 생성하고 반환하는 로직을 작성
        // 예를 들어, 현재 데이터에서 검색어를 포함하는 영화 제목들을 가져올 수 있습니다.
        let filteredTitles = allMovies
            .filter { $0.title.lowercased().contains(searchText.lowercased()) }
            .map { $0.title }

        return filteredTitles
    }
    
    // 현재 데이터의 개수를 반환
    func itemsCount() -> Int {
        return currentData.count
    }
    
    // 특정 인덱스의 값을 반환
    func item(at index: Int) -> Movie {
        return currentData[index]
    }
    
}
