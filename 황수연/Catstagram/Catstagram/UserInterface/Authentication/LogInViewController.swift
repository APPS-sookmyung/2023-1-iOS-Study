//
//  LogInViewController.swift
//  Catstagram
//
//  Created by Suyeon Hwang on 2023/03/25.
//

import UIKit

class LogInViewController: UIViewController {
    // 아래 메소드에서 텍스트 값을 받아오면 controller에서도 받아야 로직 처리 가능.
    var email: String = String()
    var password: String = String()
    var userInfo: UserInfo?
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttribute()
    }
    

    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        self.loginButton.backgroundColor = text.isValidEmail() ? UIColor(named: "facebookColor") : UIColor(named: "disabledButtonColor")
        
        self.email = text
    }
    
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        self.loginButton.backgroundColor = text.count > 2 ? UIColor(named: "facebookColor") : UIColor(named: "disabledButtonColor")
        
        self.password = text
    }
    
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        // 회원가입 정보를 전달받아서 그것과 textField 데이터가 일치하면 로그인이 되어야 함.
        
        // guard let 구문은 옵셔널을 해제하는 또다른 방법(다른 하나는 초깃값을 주는 방법임)
        // guard를 통해 데이터가 있다면 let으로 데이터 선언, 데이터가 없다면 else문으로 이동하여 해당 함수 실행이 종료됨
        guard let userInfo = self.userInfo else { return }
        if userInfo.email == self.email && userInfo.password == self.password {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        else{
            
        }
    }
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        // 화면 전환
        // 1. 스토리 보드 생성
        // 메인 스토리보드는 생성하지 않아도 자동으로 연결해주지만
        // 여러개의 스토리보드가 있으면 직접 생성해줘야 하는 원리가 있음.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. 뷰컨트롤러 생성
        // 현재 main 스토리보드에서 두 가지 뷰컨트롤러가 있는데,
        // registerVC를 생성하고 싶은 것임.
        // 아이디 값으로 접근, RegisterViewController로 다운캐스트
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
        // 3. 화면 전환 메소드를 이용하여 화면 전환
        // animated는 애니메이션 유무
        // completion은 화면 전환 후 필요한 동작이 있으면 작성, 없으면 nil
//        self.present(registerViewController, animated: true, completion: nil)
        // navigation controller 생성 후 다음과 같은 코드 작성
        self.navigationController?.pushViewController(registerViewController, animated: true)
        
        // 클로저를 사용하면 참조에 대한 문제가 생길 수 있으므로 weak self와 옵셔널 사용
        registerViewController.userInfo = { [weak self](userInfo) in
            self?.userInfo = userInfo
        }
    }
    
    private func setupAttribute() {
        // registerButton
        let text1 = "계정이 없으신가요?"
        let text2 = "가입하기"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        //let color2 = UIColor(named: "facebookColor")
        let color2 = UIColor.blue
        
        let attributes = generateButtonAttribute(
            self.registerButton,
            texts: text1, text2,
            fonts: font1, font2,
            colors: color1, color2)
        
        self.registerButton.setAttributedTitle(attributes, for: .normal)
    }
}
