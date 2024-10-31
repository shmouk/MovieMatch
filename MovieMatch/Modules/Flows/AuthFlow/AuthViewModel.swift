class AuthViewModel {
    let authAPI = AuthAPI.shared
    
    var authStateHandler: BoolCompletion?
    
    init() {
        authState()
    }
    
    func signOut() {
        authAPI.signOutAccount()
    }
    
    func authState() {
        authAPI.authStateListener { [weak self] authState in
            self?.authStateHandler?(authState)
        }
    }
    
    func registerUser(email: String?, password: String?, completion: @escaping StringCompletion) {
        authAPI.authUser(isSignIn: false, email: email, password: password) { data, error in
            guard error == nil else {
                completion(error?.localizedDescription)
                return
            }
            completion(RequestComplete.successRegister.info)
        }
    }
    
    func signInUser(email: String?, password: String?, completion: @escaping StringCompletion) {
        authAPI.authUser(isSignIn: true, email: email, password: password) { data, error in
            guard error == nil else {
                completion(error?.localizedDescription)
                return
            }
            completion(RequestComplete.successSignIn.info)
        }
    }
}
