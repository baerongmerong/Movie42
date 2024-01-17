import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var pwdField: UITextField!

    private let viewModel = SignupViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinders()
    }

    private func setUpBinders() {
        viewModel.error.bind { [weak self] error in
            if let error = error {
                print(error)
            } else {
                // 회원가입 성공 시 처리 다시 로그인페이지로
                self?.goToEntryPage()
            }
        }
    }

    // 회원가입 버튼 클릭 시
    @IBAction func signupBtnClicked(_ sender: Any) {
        guard let name = nameField.text,
              let id = idField.text,
              let pwd = pwdField.text
        else { return }
        viewModel.signup(name: name, id: id, password: pwd)
    }

    // 메인 페이지로 이동
    private func goToEntryPage() {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "EntryViewController") as? EntryViewController else {
            return
        }
        present(controller, animated: true, completion: nil)
    }
}
