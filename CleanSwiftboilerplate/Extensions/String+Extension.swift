//
//  String+Extension.swift

import UIKit
extension String {
    func attributedStringWithColor(_ strings: [String], colors: [UIColor], characterSpacing: UInt? = nil, fontSize: CGFloat? = 18) -> NSAttributedString {
        guard let font =  UIFont(name: AppFont.boldFont, size: fontSize!) else {
            return NSAttributedString()
        }
        
        let attributedString = NSMutableAttributedString(string: self)
        for (indx,string) in strings.enumerated() {
            let range = (self as NSString).range(of: string)
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: colors[indx], NSAttributedString.Key.font: font], range: range)
        }
        guard let characterSpacing = characterSpacing else {return attributedString}
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
}
enum ValidationType {
  case email
  case nonEmpty
  case numeric
  case date
  case phone
  case none
  case custom(isValid: () -> Bool)
}

extension String {
  var isAlphanumericWithNoSpaces: Bool {
    rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil
  }
  
  var hasPunctuationCharacters: Bool {
    rangeOfCharacter(from: CharacterSet.punctuationCharacters) != nil
  }
  
  var hasNumbers: Bool {
    rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789")) != nil
  }
  
  var localized: String {
    localize()
  }
  
  var withNoSpaces: String {
    filter { !$0.isWhitespace }
  }
  
  func localize(comment: String = "") -> String {
    NSLocalizedString(self, comment: comment)
  }
  
  var validFilename: String {
    guard !isEmpty else { return "emptyFilename" }
    return addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? "emptyFilename"
  }
  
  func isValid(type: ValidationType, isRequired: Bool = true) -> Bool {
    guard isRequired || !isEmpty else { return true }
    switch type {
    case .email:
      return isEmailFormatted()
    case .numeric:
      return isInteger()
    case .phone:
      return isPhoneNumber()
    case .none:
      return true
    case .custom(isValid: let validationBlock):
      return validationBlock()
    default:
      return !isEmpty
    }
  }
  
  //Regex fulfill RFC 5322 Internet Message format
  func isEmailFormatted() -> Bool {
    let predicate = NSPredicate(
      format: "SELF MATCHES %@",
      "[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(\\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*@([A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?"
    )
    return predicate.evaluate(with: self)
  }
  
  func isInteger() -> Bool {
    Int(self) != nil
  }
  
  func isPhoneNumber() -> Bool {
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", "^\\d{3}-\\d{3}-\\d{4}$")
    return phoneTest.evaluate(with: self)
  }
}
