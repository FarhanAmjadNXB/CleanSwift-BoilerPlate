//
//  LoginInteractor.swift
//  CleanSwiftboilerplate
//
//  Created by Farhan Amjad on 24.06.21.
//

import Foundation
protocol LoginBussinessLogic {
    func validateData()
    func loginService()
}

protocol UserDataStore {
  var user: User? { get }
}
