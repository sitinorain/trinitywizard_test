//
//  DetailsViewController.swift
//  contact
//
//  Created by Siti Norain Ishak on 29/05/2024.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsViewController: ScrollViewController {
    
    @IBOutlet private weak var firstNameTextField: InputTextField!
    @IBOutlet private weak var lastNameTextField: InputTextField!
    @IBOutlet private weak var emailTextField: InputTextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    private var saveButton: UIBarButtonItem!
    private let disposeBag = DisposeBag()
    
    var viewModel: DetailsViewModel!
    
    static func fromStoryboard() -> DetailsViewController {
        let viewController = R.storyboard.details.instantiateInitialViewController()!
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func configureViews() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonOnSelected(_:)))
        
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonOnSelected(_:)))
        navigationItem.rightBarButtonItem = saveButton
        
        firstNameTextField.setNextResponder(lastNameTextField, disposeBag: disposeBag)
        lastNameTextField.setNextResponder(emailTextField, disposeBag: disposeBag)
        emailTextField.setNextResponder(phoneTextField, disposeBag: disposeBag)
        phoneTextField.resignWhenFinished(disposeBag)
        
        refreshViews()
        setupTextChangeHandling()
    }
    
    private func refreshViews() {
        guard let contact = viewModel.contact else { return }
        firstNameTextField.text = contact.firstName
        lastNameTextField.text = contact.lastName
        emailTextField.text = contact.email
        phoneTextField.text = contact.phone
    }
    
    @objc private func cancelButtonOnSelected(_ sender: UIBarButtonItem) {
        viewModel.navigateBack(from: self)
    }
    
    @objc private func saveButtonOnSelected(_ sender: UIBarButtonItem) {
        guard let firstName = firstNameTextField.text else { return }
        guard let lastName = lastNameTextField.text else { return }
        if let contact = viewModel.contact {
            viewModel.saveExistingContact(id: contact.id, firstName: firstName, lastName: lastName, email: emailTextField.text, phone: phoneTextField.text)
        } else {
            viewModel.saveNewContact(firstName: firstName, lastName: lastName, email: emailTextField.text, phone: phoneTextField.text)
        }
        viewModel.navigateBack(from: self)
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

//MARK: - Rx setup
private extension DetailsViewController {
    func setupTextChangeHandling() {
        let firstNameValid = firstNameTextField
            .rx
            .text
            .map { [unowned self] in
                self.validate(name: $0)
            }
        
        firstNameValid
            .subscribe(onNext: { [unowned self] in
                self.firstNameTextField.isValid = $0
            })
            .disposed(by: disposeBag)
        
        let lastNameValid = lastNameTextField
            .rx
            .text
            .map { [unowned self] in
                self.validate(name: $0)
            }
        
        lastNameValid
            .subscribe(onNext: { [unowned self] in
                self.lastNameTextField.isValid = $0
            })
            .disposed(by: disposeBag)
        
        let emailValid = emailTextField
            .rx
            .text
            .map { [unowned self] in
                self.validate(email: $0)
            }
        
        emailValid
            .subscribe(onNext: { [unowned self] in
                self.emailTextField.isValid = $0
            })
            .disposed(by: disposeBag)
        
        let allValid = Observable
            .combineLatest(firstNameValid, lastNameValid, emailValid) {
                $0 && $1 && $2
            }

        allValid
            .subscribe(onNext: { [unowned self] in
                self.saveButton.isEnabled = $0
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - Input validation
private extension DetailsViewController {
    func validate(name: String?) -> Bool {
        //name must not be empty
        guard let name = name, !name.isWhitespace else {
            return false
        }
        return true
    }
    
    func validate(email: String?) -> Bool {
        //email is optional but must be in correct format if enter
        if let email = email, !email.isWhitespace {
            return email.isEmail

        }
        return true
    }
}
