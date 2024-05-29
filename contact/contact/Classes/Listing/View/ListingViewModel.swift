//
//  ListingViewModel.swift
//  contact
//
//  Created by Siti Norain Ishak on 29/05/2024.
//

import Foundation
import UIKit
import RealmSwift
import RxRealm
import RxSwift
import RxCocoa

class ListingViewModel: NSObject {
    private let contactService: ContactService
    private let disposeBag = DisposeBag()
    let contacts: BehaviorRelay<[Contact]> = BehaviorRelay(value: [])
    
    init(contactService: ContactService) {
        self.contactService = contactService
        super.init()
        setupObserver()
    }
    
    private func setupObserver() {
        let realm = try! Realm()
        let collection = realm.objects(Contact.self)
        
        Observable.changeset(from: collection)
            .subscribe(onNext: {
                [weak self] contacts, changes in
                if changes == nil, contacts.isEmpty {
                    self?.loadInitialData()
                } else {
                    self?.contacts.accept(Array(contacts))
                }
            })
            .disposed(by: disposeBag)
    }
    
    func loadInitialData() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        
        contactService.getContacts { response in
            switch response {
            case .success(let value):
                try! realm.write {
                    realm.add(value)
                }
            case .failure(let error):
                print("contactService.getContacts, error: \(error)")
                //TO DO - specific error handling
            }
        }
    }
    
    func navigateToDetailsView(from: UIViewController, withSelectedContact contact: Contact? = nil) {
        guard let fromViewController = from as? ListingViewController else { return }
        ListingConfigurator.shared.delegate?.navigateToDetailsViewFromListing(fromViewController, withSelectedContact: contact)
    }
}
