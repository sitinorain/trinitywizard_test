//
//  ContactService.swift
//  contact
//
//  Created by Siti Norain Ishak on 29/05/2024.
//

import Foundation
import RealmSwift

public class ContactService: ReadJsonFromFile {
    public func getContacts(completionHandler: @escaping (Result<[Contact], Error>) -> Void) {
        do {
            let responseData = self.readJson(type(of: self), fromFile: "data")
            let response = try JSONDecoder().decode([Contact].self, from: responseData ?? Data())
            if !response.isEmpty {
                DispatchQueue.main.async {
                    completionHandler(.success(response))
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(.failure(DescriptiveError("No available data")))
                }
            }
        } catch {
            DispatchQueue.main.async {
                completionHandler(.failure(DescriptiveError("Serialization Error")))
            }
        }
    }
    
    public func createNewContact(firstName: String, lastName: String, email: String?, phone: String?) {
        var dictionary = ["id": NSUUID().uuidString, "firstName": firstName, "lastName": lastName]
        if let email = email {
            dictionary["email"] = email
        }
        if let phone = phone {
            dictionary["phone"] = phone
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            let contact = try JSONDecoder().decode(Contact.self, from: jsonData)
            let realm = try! Realm()
            try! realm.write {
                realm.add(contact)
            }
        } catch {
            print(DescriptiveError("Serialization Error"))
        }
    }
    
    public func updateExistingContact(id: String, firstName: String, lastName: String, email: String?, phone: String?) {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id == %@", id)
        let existingRecords = realm.objects(Contact.self).filter(predicate)
        if let contact = existingRecords.first {
            print("update existing contact record")
            try! realm.write {
                contact.firstName = firstName
                contact.lastName = lastName
                contact.email = email
                contact.phone = phone
            }
        }
    }
}
