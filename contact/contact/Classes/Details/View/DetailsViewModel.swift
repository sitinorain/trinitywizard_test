//
//  DetailsViewModel.swift
//  contact
//
//  Created by Siti Norain Ishak on 29/05/2024.
//

import Foundation
import UIKit

class DetailsViewModel: NSObject {
    private let contactService: ContactService
    let contact: Contact?
    
    init(contact: Contact? = nil, contactService: ContactService) {
        self.contact = contact
        self.contactService = contactService
        super.init()
    }
    
    func navigateBack(from: UIViewController) {
        guard let fromViewController = from as? DetailsViewController else { return }
        fromViewController.navigationController?.popViewController(animated: true)
    }
    
    func saveNewContact(firstName: String, lastName: String, email: String?, phone: String?) {
        contactService.createNewContact(firstName: firstName, lastName: lastName, email: email, phone: phone)
    }
    
    func saveExistingContact(id: String, firstName: String, lastName: String, email: String?, phone: String?) {
        contactService.updateExistingContact(id: id, firstName: firstName, lastName: lastName, email: email, phone: phone)
    }
}
