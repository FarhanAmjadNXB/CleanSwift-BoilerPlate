//
//  FormModel.swift
//  Combine Form Validation SwiftUI & UIKit
//
//  Created by Tunde on 03/05/2021.
//

import UIKit

/**
 * Implementation for a form item
 */

protocol FormItem {
    var id: UUID { get }
    var formId: FormField { get }
    var validation: [ValidationManager] { get }
}

/**
 * Implementation for a form section
 */

protocol FormSectionItem {
    var id: UUID { get }
    var items: [FormComponent] { get }
    init(items: [FormComponent])
}

/**
 * Unique identifiers for form items
 */

enum FormField: String, CaseIterable {
    case firstName
    case lastName
    case email
    case password
    case dob
    case checkBox
    case submit
}

/**
 * Component for a form section the form
 */

final class FormSectionComponent: FormSectionItem, Hashable {

    let id: UUID = UUID()
    var items: [FormComponent]

    required init(items: [FormComponent]) {
        self.items = items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
  
    static func == (lhs: FormSectionComponent, rhs: FormSectionComponent) -> Bool {
        lhs.id == rhs.id
    }
}

/**
 * Component for a form items the form
 */

class FormComponent: FormItem, Hashable {

    let id = UUID()
    let formId: FormField
    var value: Any?
    var validation: [ValidationManager]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: FormComponent, rhs: FormComponent) -> Bool {
        lhs.id == rhs.id
    }
    
    init(_ id: FormField, validation: [ValidationManager] = []) {
        self.formId = id
        self.validation = validation
    }
}

/**
 * Component for a text item in the form
 */

final class TextFormComponent: FormComponent {
   
    let placeholder: String
    let keyboardType: UIKeyboardType
    //var validation:
    init(id: FormField,
        placeholder: String,
        keyboardType: UIKeyboardType = .default, validation: [ValidationManager]) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        super.init(id)
        self.validation = validation
    }
}

/**
 * Component for a date item in the form
 */

final class DateFormComponent: FormComponent {

    let mode: UIDatePicker.Mode
    
    init(id: FormField,
         mode: UIDatePicker.Mode) {
        self.mode = mode
        super.init(id)
    }
}

/**
 * Component for a button item in the form
 */

final class ButtonFormItem: FormComponent {

    let title: String
    
    init(id: FormField,
         title: String) {
        self.title = title
        super.init(id)
    }
}



final class CheckBox: FormComponent {

    let isChecked: Bool
    
    init(id: FormField,
         status: Bool) {
        self.isChecked = status
        super.init(id)
    }
}
