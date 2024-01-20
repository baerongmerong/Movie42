import UIKit

class MyPageViewController : UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var movieTV: UITableView!
    
    var user: User?
    
    private let viewModel = MyPageViewModel()

    override func viewDidLoad() {
            super.viewDidLoad()
        userImage.image = UIImage(named: "cat")
            setUpBinders()
            updateUI()
        
        movieTV.dataSource = self
        movieTV.delegate = self
        
        if let loggedInUser = UserDefaultManager.shared.getLoggedInUser() {
                    user = loggedInUser
                    movieTV.reloadData() // 테이블 뷰 업데이트
                }
        }

    private func setUpBinders() {
        viewModel.change.bind { [weak self] change in
            if let change = change {
                print(change)
                self?.updateUI()
            }
        }
    }

    private func updateUI() {
        if let loggedInUser = UserDefaultManager.shared.getLoggedInUser() {
            id.text = "ID: \(loggedInUser.userid)"
            nickname.text = "닉네임: \(loggedInUser.nickname)"
        }
    }
    
    //개인정보 수정하는 버튼 눌렀을때
    @IBAction func changeUserInfoBtntapped(_ sender: Any) {
        showChangeUserInfoAlert()
    }
    private func showChangeUserInfoAlert() {
        let alert = UIAlertController(title: "사용자 정보 수정", message: "새로운 ID와 닉네임을 입력하세요", preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "새로운 ID"
        }

        alert.addTextField { textField in
            textField.placeholder = "새로운 닉네임"
        }

        let saveAction = UIAlertAction(title: "저장", style: .default) { [weak self] _ in
            guard let self = self else { return }

            if let newID = alert.textFields?.first?.text,
               let newNickname = alert.textFields?.last?.text {
                // 뷰 모델에 업데이트 요청
                self.viewModel.updateUser(newID: newID, newNickname: newNickname)
                self.nickname.text = "닉네임: \(newNickname)"
                self.id.text = "ID: \(newID)"
                }
            }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
}
    
extension MyPageViewController : UITableViewDataSource, UITableViewDelegate {
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return user?.reservations.count ?? 0
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reservationCell", for: indexPath)
            if let reservation = user?.reservations[indexPath.row] {
                // 셀에 예약 정보를 표시
                cell.textLabel?.text = " \(reservation.movieTitle) | \(reservation.numberOfTickets)명"
            }
            
            return cell
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if let reservation = user?.reservations[indexPath.row] {
             showReservationDetailsAlert(for: reservation)
         }
     }

    private func showReservationDetailsAlert(for reservation: Reservation) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 M월d일 h:mm a"
            
            let dateString = formatter.string(from: reservation.date)
            
            let message = """
        
        \(dateString)
        \(reservation.numberOfTickets)명
        
        - 영화 예매는 Move 42 -
        """
            
            let alert = UIAlertController(title: "\(reservation.movieTitle)", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
        }

    
}
