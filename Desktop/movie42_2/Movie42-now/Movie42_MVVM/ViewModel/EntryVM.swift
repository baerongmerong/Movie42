import Foundation

final class EntryViewModel {
    
    var error: ObservableObject<String?> = ObservableObject("")
    
    func login(id: String, password: String) {
        NetworkService.shared.login(id: id, password: password) {
            [weak self] success in
            print("NetworkService에 대한 completion 값", success)
            if success {
                print("Login successful")
                self?.error.value = nil
            } else {
                print("Login failed")
                self?.error.value = "로그인에 실패했습니다."
            }
        }
    }
}
