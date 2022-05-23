//
//  DashboardVM.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 12/04/2022.
//

import Contacts
import FinanceCoreData
import Foundation
import Shared
import SSUtils
import Contacts
import UIKit

final class DashboardVM: ViewModel {
    
    @Published private(set) var topExpenses: HorizontalBarVD?
    
    func loadData() async {
        //        let thisMonthExpenses = await CashFlowEntity.getAll(from: controller, filter: .type(.expense), .monthAndYear(from: .now))
        //        let totalExpenses = thisMonthExpenses.reduce(Decimal(0)) { $0 + $1.value }.asDouble
        //
        //        let expenseBars = Dictionary(grouping: thisMonthExpenses, by: { $0.category })
        //            .mapValues { $0.map { $0.value }.reduce(0, +) }
        //            .map { HorizontalBarVD.Bar(title: $0.key.name, value: $0.value.asDouble, color: $0.key.color.color) }
        //            .sorted(by: { $0.value > $1.value })
        //            .prefix(3)
        //
        //        DispatchQueue.main.async { [weak self] in
        //            if expenseBars.isNotEmpty {
        //                self?.topExpenses = .init(bars: Array(expenseBars), total: totalExpenses)
        //            }
        //        }
    }
}

final class ContactsGenerator {
    func getPhoneNumbers() -> [String] {
        let dir = Bundle.main.path(forResource: "p2pFriendsList", ofType: "txt")!
        let numbersTxt = try! String(contentsOfFile: dir)
        return numbersTxt.components(separatedBy: ",").map { $0.trim }
    }

    func createContacts() -> [CNContact] {
        let phoneNumbers = getPhoneNumbers()

        let contacts = phoneNumbers.map { number -> CNContact in
            let number = String(number.dropFirst().dropLast(1))
            let phonenumber = "+965\(number)"
            let contact = CNMutableContact()
            contact.givenName = randomString(length: [6,7,8,9,10].randomElement()!)
            contact.phoneNumbers = [
                CNLabeledValue(label: CNLabelPhoneNumberiPhone, value: CNPhoneNumber(stringValue: phonenumber))
            ]
            return contact
        }

        return contacts
    }

    func getFileURL() -> URL {
        let contacts = createContacts()

        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let fileURL = dir
            .appendingPathComponent("fakeContacts")
            .appendingPathExtension("vcf")

        let data = try! CNContactVCardSerialization.data(with: contacts)
        try! data.write(to: fileURL)

        return fileURL
    }
}

func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}
