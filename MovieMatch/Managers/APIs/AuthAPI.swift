import Firebase

class AuthAPI: APIProtocol {
    static var shared = AuthAPI()
    private var handle: AuthStateDidChangeListenerHandle?
    
    private init() {
        firebaseConfigure()
    }
    
    deinit {
        firebaseRemove()
    }
    
    func firebaseRemove() {
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
    }

    func authStateListener(completion: @escaping BoolCompletion) {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            completion(user != nil ? true : false)
        }
    }

    func authUser(isSignIn: Bool, email: String?, password: String?, completion: @escaping RegisterResult) {
        guard let email = email,
              let password = password else {
            completion(nil, RequestError.emptyFields)
            return
        }
        
        guard isValidEmail(email: email) else {
            completion(nil, RequestError.invalidEmail)
            return
        }
        
        guard isSignIn else {
            Auth.auth().createUser(withEmail: email, password: password, completion: completion)
            return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func isEmptyFields(email: String, password: String) -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            return false
        }
        return true
    }
        
    private func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
