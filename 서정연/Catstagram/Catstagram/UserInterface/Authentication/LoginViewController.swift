//
//  LoginViewController.swift
//  Catstagram
//
//  Created by Seo Cindy on 2023/03/28.
//

import UIKit
// Alomofire 추가
import Alamofire
class LoginViewController: UIViewController {
    
    var email = String()
    var pwd = String()
    var userInfo: UserInfo?

    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAttribute()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
//        if text.isValidEmail() {
//            self.loginButton.backgroundColor = UIColor(named: "FacebookColor")
//            self.loginButton.isEnabled = true
//        }else{
//            self.loginButton.backgroundColor = UIColor(named: "disabledButtonColor")
//            self.loginButton.isEnabled = false
//        }
        // => 삼항연산자
        self.loginButton.backgroundColor =
        text.isValidEmail() ? UIColor(named: "FacebookColor") : UIColor(named: "disabledButtonColor")
        
        self.email = text
    }
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.loginButton.backgroundColor =
        text.count > 2 ? UIColor(named: "FacebookColor") : UIColor(named: "disabledButtonColor")
        
        self.pwd = text
    }
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        // 회원가입 정보를 전달받음
        // 그것과 텍스트 필드 데이터가 일치 시 로그인되어야 함
        guard let userInfo = self.userInfo else {return}
        if userInfo.email == self.email &&
            userInfo.password == self.pwd{
            
            // 화면 전환
            let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
            
            // 코드 변경 전
            //vc.modalPresentationStyle = .fullScreen
            //self.present(vc, animated: true, completion: nil)
            
            // 코드 변경 후
            self.view.window?.windowScene?.keyWindow?.rootViewController = vc
        }
        
    }
    
    
    @IBAction func refisterButtonDidTap(_ sender: UIButton) {
        // 화면전환
        // 1. 스토리보드 생성
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. 뷰 컨트롤러를 생성
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
        
        // 3. 화면 전환 메소드를 이용해서 화면을 전환
        //self.present(registerViewController, animated: true, completion: nil)
        // animation : 애니메이션 유무, completion : 화면전환 이후에 필요한 동작이 있으면 코드 작성
        
        // navigation
        self.navigationController?.pushViewController(registerViewController, animated: true)
        
        // ARC -> 약한 참조
        // ARC를 낮춰줌 -> 메모리 해제 시 같이 해제되도록
        registerViewController.userInfo = {[weak self] (userInfo) in
            self?.userInfo = userInfo
        }
    }
    
    private func setUpAttribute(){
        // registerButton
        let text1 = "계정이 없으신가요?"
        let text2 = "가입하기"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        // let color2 = UIColor(named: "FacebookColor")
        let color2 = UIColor.blue
        
        let attributes = self.generateButtonAttribute(
            registerButton,
            texts: text1, text2,
            fonts: font1,font2,
            colors: color1, color2)
        
        // 적용하기
        self.registerButton.setAttributedTitle(attributes, for: .normal)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
