//
//  ViewController.swift
//  DesafioLogin
//
//  Created by Jorge on 14/09/20.
//  Copyright © 2020 Jorge. All rights reserved.
//

import UIKit

class Usuario {
    private var email: String
    private var senha: String
    
    init(email: String, senha: String) {
        self.email = email
        self.senha = senha
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func getSenha() -> String {
        print("getSenha")
        return self.email
    }
    
    func setEmail(_ email: String) {
        print(email)
        self.email = email
    }
    
    func setSenha(_ senha: String) {
        print(senha)
        self.senha = senha
    }
}

class ViewController: UIViewController {
    var usuario: Usuario = Usuario(email: "", senha: "")
    var usuariosCadastrados = [Usuario]()
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldSenha: UITextField!
    
    @IBOutlet weak var btnCadastrar: UIButton!
    
    @IBAction func btnCadastrarAction(_ sender: Any) {
        if usuariosCadastrados.count == 0 {
            usuario.setEmail(textFieldEmail.text!)
            usuario.setSenha(textFieldSenha.text!)
            usuariosCadastrados.append(usuario)
            
            textFieldEmail.text = ""
            textFieldSenha.text = ""
        }
        else {
            for element in usuariosCadastrados {
                if(element.getEmail() == textFieldEmail.text!) {
                    mostrarAlerta("Usuario já cadastrado! Tente outro!")
                    view.backgroundColor = UIColor.red
                    break
                }
                usuario.setEmail(textFieldEmail.text!)
                usuario.setSenha(textFieldSenha.text!)
                usuariosCadastrados.append(usuario)
                
                textFieldEmail.text = ""
                textFieldSenha.text = ""
                
                view.backgroundColor = UIColor.green
            }
        }
        

        print(usuario.getEmail())
    }
    
    func mostrarAlerta(_ mensagem: String) {
        // Comeca alerta
        let alert = UIAlertController(title: "Atenção", message: mensagem, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .cancel) {
            (UIAlertAction) in
        }
        alert.addAction(okAction)
        self.present(alert, animated: true) {
           
        }
        // Termina alerta
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnCadastrar.isEnabled = false
        textFieldEmail.delegate = self
        textFieldSenha.delegate = self
    }
    
    private func validarTextFields() -> Bool {
        if(textFieldEmail.text == nil || textFieldEmail.text!.isEmpty) {
            mostrarAlerta("Falta o Email!")
            return false
        }
        if(textFieldSenha.text == nil || textFieldSenha.text!.isEmpty) {
            mostrarAlerta("Falta o Senha!")
            return false
        }
        return true
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldEmail {
            textFieldSenha.becomeFirstResponder()
        }
        else if textField == textFieldSenha {
            if validarTextFields() {
                btnCadastrar.isEnabled = true
            }
        }
        return true
    }
}

