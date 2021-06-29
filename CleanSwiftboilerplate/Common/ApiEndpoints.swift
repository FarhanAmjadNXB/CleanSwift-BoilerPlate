//
//  File.swift
//  CleanSwiftboilerplate
//
//  Created by Farhan Amjad on 24.06.21.
//

import Foundation

protocol NetworkInfo {
    //func baseURl() -> String
}

struct Network {
    
    //MARK: -  Onboarding
    enum Onboarding: NetworkInfo {
        
        case login
        case signUp
        case resend_otp
        case logout
        case apiCall(String)
        
        func rawValued() -> String {
            switch self {
            case .login:
                return  "userLogin"
            case .signUp:
                return "signUp"
            case .resend_otp:
                return "resend_otp"
            case .logout:
                return  "logout"
            case .apiCall(let val):
                return  "apiCall/\(val)"
            }
        }
        static func baseURl() -> String {
            return Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
        }
    }
    
    //MARK: -  Boarded
    enum ModuleB: NetworkInfo {
        case dashboard
        func rawValued() -> String {
            switch self {
            case .dashboard:
                return "dashboard"
            }
        }
        func baseURl() -> String {
            return Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
        }
    }
}
