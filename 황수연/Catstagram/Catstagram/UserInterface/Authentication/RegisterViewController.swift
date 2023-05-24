//
//  RegisterViewController.swift
//  Catstagram
//
//  Created by Suyeon Hwang on 2023/03/25.
//

import UIKit

class RegisterViewController: UIViewController {
    // MARK: - Properties
    var email: String = ""
    var name: String = ""
    var nickname: String = ""
    var password: String = ""
    
    // 이전 컨트롤러인 loginViewController에 데이터를 전달하기 위해
    // 파라미터로 UserInfo를 인풋하고 리턴은 필요없는 함수 표현식임
    var userInfo: ((UserInfo) -> Void)?
    
    // 유효성 검사를 위한 프로퍼티
    var isValidEmail = false{
        didSet{  // property observer
            self.validateUserInfo()
        }
    }
    
    var isValidName = false{
        didSet{  // property observer
            self.validateUserInfo()
        }
    }
    
    var isValidNickname = false{
        didSet{  // property observer
            self.validateUserInfo()
        }
    }
    
    var isValidPassword = false{
        didSet{  // property observer
            self.validateUserInfo()
        }
    }
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var popToLoginButton: UIButton!
    
    // TextFields
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var textFields: [UITextField] {
        [emailTextField, nameTextField, nicknameTextField, passwordTextField]
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupAttribute()
        
        // bug fix
        // 스와이프했을 때도 이전 화면으로 이동하도록
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    // MARK: - Actions
    @objc
    func textFieldEditingChanged(_ sender: UITextField){
        // 초기화로 optional 해제
        let text = sender.text ?? ""
        
        switch sender {
        case emailTextField:
            self.isValidEmail = text.isValidEmail()
            self.email = text
            
        case nameTextField:
            self.isValidName = text.count > 2
            self.name = text
            
        case nicknameTextField:
            self.isValidNickname = text.count > 2
            self.nickname = text
            
        case passwordTextField:
            self.isValidPassword = text.isValidPassword()
            self.password = text
            
        default:
            fatalError("Missing Textfield...")
        }
    }
    
    // event는 touch up inside로, 클릭했을 때 호출되도록
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        // 뒤로 가기 되어야 함.
        self.navigationController?.popViewController(animated: true)
        
        // 이전 컨트롤러에 데이터 전달
        // 데이터를 전달할 때 세그웨이나 델리게이트 패턴 사용할 수 있음
        // 여기서는 클로저 사용
        let userInfo = UserInfo(
            email: self.email,
            name: self.name,
            nickname: self.nickname,
            password: self.password
        )
        
        // 데이터 전달
        self.userInfo?(userInfo)
    }
    
    
    @IBAction func backButtonDidTap(_ sender: UIBarButtonItem) {
        // 뒤로 가기
        // popViewController는 이전화면으로 돌아감
        // 로그인 화면에서는 pushViewController 썼었음. push의 역방향이 pop
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    // MARK: - Helpers
    private func setupTextField(){
        // textFields 배열에서 각 하나에 대해 addTarget
        textFields.forEach{ tf in
            tf.addTarget(self,
                         action: #selector(textFieldEditingChanged(_:)),
                         for: .editingChanged)
        }
        // emailTextField에서 이벤트가 오면
        // target은 누가 처리할지에 대한 것임. 여기서는 이 컨트롤러, 즉 registercontroller가 처리를 하는데, 여기서는 내부에 있으므로 self로 접근 가능
        // textFIeldEditingChanged() 메소드 내부에서 처리할 것이기 때문에 action은 #selector(textFieldEditingChanged(_:))
        // for 파라미터는 어떤 이벤트에 대해 처리할지.
    }
    
    // 사용자가 입력한 회원정보 확인, UI 업데이트
    private func validateUserInfo() {
        if isValidEmail && isValidName && isValidNickname && isValidPassword{
            
            self.signupButton.isEnabled = true
            // withDuration: 애니메이션 진행 시간, animation: 애니메이션 동작 코드
            UIView.animate(withDuration: 0.33) {
                self.signupButton.backgroundColor = UIColor(named: "facebookColor")
            }
        }
        else{
            // 유효성 검사 -> 유효하지 않음
            self.signupButton.isEnabled = false
            UIView.animate(withDuration: 0.33) {
                self.signupButton.backgroundColor = UIColor(named: "disabledButtonColor")
            }
        }
    }
    
    private func setupAttribute(){
        // popToLoginButton
        let text1 = "계정이 있으신가요?"
        let text2 = "로그인"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        //let color2 = UIColor(named: "facebookColor")
        let color2 = UIColor.blue
        
        let attributes = generateButtonAttribute(
            self.popToLoginButton,
            texts: text1, text2,
            fonts: font1, font2,
            colors: color1, color2)
        
        self.popToLoginButton.setAttributedTitle(attributes, for: .normal)
    }
}

extension String {
    // 대문자, 소문자, 특수문자, 숫자가 8자 이상인지 확인.
    func isValidPassword() -> Bool {
        // 조건
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        // 조건에 대해 평가
        return passwordValidation.evaluate(with: self)
    }
    
    // @ 포함하는지, 2글자 이상인지 확인
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
