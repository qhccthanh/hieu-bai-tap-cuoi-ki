//
//  SignUpViewController.swift
//  AcoutApp
//
//  Created by James on 9/11/18.
//

import UIKit
import SnapKit
import SVProgressHUD
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    fileprivate let emailTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.placeholder = " Email "
        textField.font = UIFont.systemFont(ofSize: 14)
        //textField.backgroundColor = .black
        return textField
    }()
    
    fileprivate let passwordTextField: UITextField = {
       let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = " Password"
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    fileprivate let conpassTextField: UITextField = {
       let textField = UITextField()
        textField.isSecureTextEntry =  true
        textField.placeholder = " Confirm Password "
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    fileprivate  let nickTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .default
        textField.placeholder = " Nick Name "
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    fileprivate let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign-Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.setupContrains()
    }
    
    fileprivate func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(conpassTextField)
        self.view.addSubview(nickTextField)
        self.view.addSubview(signUpButton)
        
        self.signUpButton.addTarget(self, action: #selector(self.didTapSignUpBtn(_:)), for: .touchUpInside)
        
    }
    
    fileprivate func setupContrains() {
        let defaultInsetHorizontal = 40
        let defaultInsetVertical = 10
        
        self.emailTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(defaultInsetHorizontal)
            make.right.equalToSuperview().offset(-defaultInsetHorizontal)
            make.height.equalTo(34)
        }
        
        self.passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.emailTextField.snp.bottom).offset(defaultInsetVertical)
            make.left.right.height.equalTo(self.emailTextField)
        }
        
        self.conpassTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(defaultInsetVertical)
            make.left.right.height.equalTo(self.emailTextField)
        }
        
        self.nickTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.conpassTextField.snp.bottom).offset(defaultInsetVertical)
            make.left.right.height.equalTo(self.emailTextField)
        }
        
        self.signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.nickTextField.snp.bottom).offset(defaultInsetVertical)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
    }
    
    @objc fileprivate func didTapSignUpBtn(_ sender: Any) {
        guard let email = self.emailTextField.text,
            let password = self.passwordTextField.text,
            let verifyPass = self.conpassTextField.text,
            let nick = self.nickTextField.text else {
                SVProgressHUD.showError("Bạn chưa nhập đẩy đủ dữ liệu vui lòng nhập đầy đủ")
                return
        }
        
        // Khong phai la email
        if !email.isEmail {
            SVProgressHUD.showError("\(email) Đây không phải là email ")
            return
        }
        
        if password != verifyPass {
            SVProgressHUD.showError("Mật khẩu không giống nhau")
            return
        }
        
        if password.count < 6 {
            SVProgressHUD.showError("Mật khẩu lớn hơn 6 ký tự")
            return
        }
        
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            SVProgressHUD.dismiss()
            if let error = error {
                SVProgressHUD.showError(error.localizedDescription)
                return
            }
            
            FirebaseData.shared.userRef.child(result?.user.uid ?? "").setValue([
                "email": result?.user.email ?? "",
                "id": result?.user.uid ?? ""
                ])
            
            SVProgressHUD.showSuccess("Đăng Nhập Thành Công", completion: {
                self.dismiss(animated: true, completion: nil)
            })
        }
    }

}
