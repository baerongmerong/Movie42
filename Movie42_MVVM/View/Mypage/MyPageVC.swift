import UIKit

class MyPageViewController : UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var id: UILabel!
    
    private let viewModel = MyPageViewModel()

    override func viewDidLoad() {
            super.viewDidLoad()
            setUpBinders()
            updateUI()
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
            nickname.text = "Nickname: \(loggedInUser.nickname)"
        }
    }
    
    //개인정보 수정하는 버튼 눌렀을때
    @IBAction func changeUserInfoBtntapped(_ sender: Any) {
        showChangeUserInfoAlert()
    }
    private func showChangeUserInfoAlert() {
        let alert = UIAlertController(title: "사용자 정보 변경", message: "새로운 ID와 닉네임을 입력하세요", preferredStyle: .alert)

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
                self.nickname.text = "Nickname: \(newNickname)"
                self.id.text = "ID: \(newID)"
                }
            }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
}
    


