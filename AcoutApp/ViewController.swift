//
//  ViewController.swift
//  AcoutApp
//
//  Created by James on 9/6/18.
//

import UIKit
import SnapKit
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit

class ViewController: UIViewController {
    
    fileprivate let emailTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.placeholder = " Email "
        //textField.backgroundColor = .black
        return textField
    }()
    
    fileprivate let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = " Password "
        return textField
    }()
    
    fileprivate let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Login ", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    fileprivate let faceInButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Login By FaceBook ", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    fileprivate let googleInButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Login By GooGle ", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    fileprivate let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Sign Up ", for: .normal)
        button.setTitleColor(.green, for: .normal)
        return button
    }()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupView()
        self.setupContrains()
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        
        if let user = UserManager.share.getCurrentUser(){
            
        print(user)
        }
        
    }
    
    fileprivate func setupView(){
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(signInButton)
        self.view.addSubview(faceInButton)
        self.view.addSubview(googleInButton)
        self.view.addSubview(signUpButton)
        //self.view.backgroundColor = .lightGray
        self.signInButton.addTarget(self, action: #selector(self.didTapSignInButton(_:)), for: .touchUpInside)
        self.signUpButton.addTarget(self, action: #selector(self.didTapSignUpButton(_:)), for: .touchUpInside)
        self.faceInButton.addTarget(self, action: #selector(self.didTapFaceButton(_:)), for: .touchUpInside)
        self.googleInButton.addTarget(self, action: #selector(self.didTapGooGleButton(_:)), for: .touchUpInside)
    }
    
    fileprivate func setupContrains(){
        self.emailTextField.snp.makeConstraints {(make) in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        self.passwordTextField.snp.makeConstraints {(make) in
            make.top.equalTo(self.emailTextField.snp.bottom).offset(10)
        }
        self.signInButton.snp.makeConstraints {(make) in
            make.bottom.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
        }
        self.faceInButton.snp.makeConstraints {(make) in
            make.bottom.equalTo(self.signInButton.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
        self.googleInButton.snp.makeConstraints {(make) in
            make.bottom.equalTo(self.faceInButton.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
        self.signUpButton.snp.makeConstraints {(make) in
            make.bottom.equalTo(self.googleInButton.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc fileprivate func didTapSignInButton (_ sender: Any!){
        
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            if let error = error {
                // AuthErrorCode.wrongPassword
                print(error.localizedDescription)
                
                return
            }
            
            print(result?.user)
            print(result?.additionalUserInfo)
            self.handleLoginSucceed(user: result?.user)
        }
        
    }
    
    @objc fileprivate func didTapSignUpButton (_ sender: Any!){
        let signUpViewController = SignUpViewController()
        self.present(signUpViewController, animated: true, completion: nil)
    }
    
    @objc fileprivate func didTapFaceButton (_ sender: Any!){
        let loginFaceManager = FBSDKLoginManager()
        loginFaceManager.logIn(withPublishPermissions: ["email", "public_profile"], from: self) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    // ...
                    return
                }
                print(authResult?.user)
                print(authResult?.additionalUserInfo)
                print(authResult?.additionalUserInfo?.profile)
                self.handleLoginSucceed(user: authResult?.user)
            }
        }
    }
    
    fileprivate func handleLoginSucceed(user: User?) {
        
        guard let fireUser = user else {return}
        
        FirebaseData.shared.userRef.child(fireUser.uid).setValue([
            "name": fireUser.displayName ?? "",
            "email": fireUser.email ?? "",
            "id": fireUser.uid,
            "avatar_url": fireUser.photoURL?.absoluteString ?? "",
            "dialog_ids": []
            ])
        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "MainTabController") else {
            return
        }
        
        self.present(controller, animated: true, completion: nil)

        
    }
    

    @objc fileprivate func didTapGooGleButton (_ sender: Any!){
        GIDSignIn.sharedInstance().signIn()

    }
    
}

extension ViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                return
            }
            print(authResult?.user)
            print(authResult?.additionalUserInfo)
            print(authResult?.additionalUserInfo?.profile)
            self.handleLoginSucceed(user: authResult?.user)

        }
    }
    
    
}



