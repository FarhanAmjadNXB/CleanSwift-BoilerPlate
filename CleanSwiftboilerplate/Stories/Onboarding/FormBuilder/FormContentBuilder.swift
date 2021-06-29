//
//  FormContentBuilder.swift
//  Combine Form Validation SwiftUI & UIKit
//
//  Created by Tunde on 03/05/2021.
//

import Foundation

enum RegexPatterns {
    static let emailChars = ".*[@].*"
    static let higherThanSixChars = "^.{6,}$"
    static let name = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
    
    static let uppercase = "(?=.*?[A-Z])"
    static let lowercase = "(?=.*?[a-z])"
    static let oneDigit = "(?=.*?[0-9])"
    static let specialCharacter = "(?=.*?[#?!@$%^&*-])"
    static let minimumLength = ".{8,}"
}

final class FormContentBuilderImpl {
        
    private(set) var formContent = [
            FormSectionComponent(items: [
                TextFormComponent(id: .firstName,
                                  placeholder: "First Name", validation: [RegexValidatorManager([RegexFormItem(patten: RegexPatterns.name, error: .custom(message: "Invalid Name"))])]),
                TextFormComponent(id: .lastName,
                                  placeholder: "Last Name", validation: [RegexValidatorManager([RegexFormItem(patten: RegexPatterns.name, error: .custom(message: "Invalid Name"))])]),
                TextFormComponent(id: .email,
                                  placeholder: "Email",
                                  keyboardType: .emailAddress, validation: [RegexValidatorManager([RegexFormItem(patten: RegexPatterns.emailChars, error: .custom(message: "Invalid Email")), RegexFormItem(patten: RegexPatterns.higherThanSixChars, error: .custom(message: "Less then 6 characters"))])]),
                TextFormComponent(id: .password,
                                  placeholder: "Password",
                                  keyboardType: .emailAddress, validation: [RegexValidatorManager([
                                RegexFormItem(patten: RegexPatterns.uppercase, error: .custom(message: "At least one upper case")),
                                RegexFormItem(patten: RegexPatterns.lowercase, error: .custom(message: "At least one lower case")),
                                RegexFormItem(patten: RegexPatterns.oneDigit, error: .custom(message: "At least one digit")),
                                
                                RegexFormItem(patten: RegexPatterns.specialCharacter, error: .custom(message: "At least one special character")),
                                RegexFormItem(patten: RegexPatterns.minimumLength, error: .custom(message: "Minimum eight in length"))
                                  ])]),
        /*        DateFormComponent(id: .dob,
                                  mode: .date),*/
                
                CheckBox(id: .checkBox, status: false),
                ButtonFormItem(id: .submit,
                               title: "SignUp")
                
            ])
        ]

    func update(val: String, at indexPath: IndexPath) {
        formContent[indexPath.section].items[indexPath.row].value = val
    }
}
