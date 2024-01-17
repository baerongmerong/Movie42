import Foundation

//회원가입 된 유저의 구조체
struct User : Codable {
    var name : String
    var userid : String
    var pwd : String
}

//userdefault로 저장하게 하는 manager
class UserDefaultManager {
    static let shared = UserDefaultManager()

    private let userDefaults: UserDefaults

    init() {
        self.userDefaults = UserDefaults.standard
    }

    var datas: [User] {
        get {
            if let savedData = userDefaults.data(forKey: "users"),
               let decodedData = try? JSONDecoder().decode([User].self, from: savedData) {
                return decodedData
            }
            return []
        }
        set {
            if let encodedData = try? JSONEncoder().encode(newValue) {
                self.userDefaults.set(encodedData, forKey: "users")
            }
        }
    }
}
