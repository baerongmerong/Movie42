import Foundation

class ReservationViewModel {
    var selectedMovie: Movie?
    var selectedDate: Date?
    var selectedTime: String? = "12:00 PM"
    var selectedNumberOfTickets: Int? = 0
    
    // 예매 정보를 저장하고 현재 로그인된 유저에 연결하는 메서드
    func saveReservation(with user : User?, with movie: Movie?, with date: Date? ) {
        print("saveReservation called") // 디버깅
        
        guard var currentUser = user,
              let selectedMovie = movie,
              let selectedDate = date else {
            // 필요한 값이 없으면 리턴
            print("currentUser, selectedMovie, or selectedDate is nil")
            return
        }
        
        // 예매 정보 생성
        let reservation = Reservation(movieTitle: selectedMovie.title, date: selectedDate,
                                      time: selectedTime ?? "12:00 PM", // 선택된 시간이 없을 경우 기본값 설정
                                      numberOfTickets: selectedNumberOfTickets ?? 0) // 선택된 티켓 수가 없을 경우 기본값 설정
        print("\(selectedMovie.title), \(selectedDate)")
        
        // 유저 정보 업데이트
        currentUser.reservations.append(reservation)
        
        // UserDefaultManager를 활용하여 유저 정보 업데이트
        UserDefaultManager.shared.updateLoggedInUser(currentUser)
    }
    
    var currentUser: User? {
        // 현재 로그인된 유저 정보를 가져오거나 설정하는 부분
        get {
            if let userData = UserDefaults.standard.data(forKey: "currentUser"),
               let user = try? JSONDecoder().decode(User.self, from: userData) {
                return user
            }
            return nil
        }
        set {
            if let userData = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(userData, forKey: "currentUser")
            }
        }
    }
}
