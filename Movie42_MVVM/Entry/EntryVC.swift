import UIKit

class EntryViewController : UIViewController {
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    
    private let viewModel = EntryViewModel()
    private let defaults = UserDefaultManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinders()
    }
    
    private func setUpBinders() {
        viewModel.error.bind { [weak self] error in
            if let error = error {
                print(error)
            } else {
                self?.goToMovieList()
            }
        }
    }
    
    //영화목록으로 가는 함수
    private func goToMovieList() {
        let storyboard = UIStoryboard(name: "MovieListView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MoviewListViewController") as UIViewController
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        //확인용으로 알람창 띄우기
//        let alert = UIAlertController(title: "로그인 성공", message: "간단한 메시지", preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
//            print("확인 버튼이 눌렸습니다.")
//        }
//        alert.addAction(okAction)
//        present(alert, animated: true, completion: nil)
    }
    
    //처음회원가입 하는 경우
    @IBAction func signupBtnClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SignupView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as UIViewController
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
    //로그인 버튼 눌러서 아이디 패스워드 확인
    @IBAction func loginBtnClicked(_ sender: Any) {
        guard let id = idField.text,
              let pwd = pwdField.text
        else { return }
        viewModel.login(id: id, password: pwd)
    }
}
