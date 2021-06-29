//
//  BaseService.swift

import Foundation
import UIKit

protocol AuthenticationRepository {
    func login(email: String, password: String, success: @escaping () -> Void,
               failure: @escaping (_ error: Error) -> Void)
    func signUp(_ email: String,
                password: String,
                avatar: UIImage,
                success: @escaping (_ user: User?) -> Void,
                failure: @escaping (_ error: Error) -> Void)
}

class AuthenticationServices: AuthenticationRepository {
 
    var baseURL: String!
    init() {
        self.baseURL =  Network.Onboarding.baseURl()
    }
    
    func login(email: String, password: String, success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        let url = self.baseURL + Network.Onboarding.login.rawValued()
        let parameters = [
            "user": [
                "email": email,
                "password": password
            ]
        ]
        APIClient.request(.post, url: url, params: parameters, success: { response, headers in
            AuthenticationServices.saveUserSession(fromResponse: response, headers: headers)
            success()
        }, failure: { error in
            failure(error)
        })
    }
    
    //Multi part upload example
    //TODO: rails base backend not supporting multipart uploads yet
    func signUp(_ email: String, password: String, avatar: UIImage, success: @escaping (User?) -> Void, failure: @escaping (Error) -> Void) {
        let parameters = [
            "user": [
                "email": email,
                "password": password,
                "password_confirmation": password
            ]
        ]
        
        guard let picData = avatar.jpegData(compressionQuality: 0.75) else {
            failure(App.error(
                domain: .parsing,
                code: 1000,
                localizedDescription: "Could not parse image"
            ))
            return
        }
        let image = MultipartMedia(key: "user[avatar]", data: picData)
        //Mixed base64 encoded and multipart images are supported in [MultipartMedia] param:
        //Example: let image2 = Base64Media(key: "user[image]", data: picData) Then: media [image, image2]
        APIClient.multipartRequest(
            url: self.baseURL + Network.Onboarding.login.rawValued(),
            params: parameters,
            paramsRootKey: "",
            media: [image],
            success: { response, headers in
                AuthenticationServices.saveUserSession(fromResponse: response, headers: headers)
                success(UserDataManager.currentUser)
            },
            failure: failure
        )
    }
    
    
    //Example method that uploads base64 encoded image.
    class func signup(_ email: String,
                      password: String,
                      avatar64: UIImage,
                      success: @escaping (_ user: User?) -> Void,
                      failure: @escaping (_ error: Error) -> Void) {
        var userParameters: [String: Any] = [
            "email": email,
            "password": password,
            "password_confirmation": password
        ]
        
        if let picData = avatar64.jpegData(compressionQuality: 0.75) {
            userParameters["image"] = picData.asBase64Param()
        }
        
        let parameters = [
            "user": userParameters
        ]
        
        APIClient.request(
            .post,
            url: Network.Onboarding.signUp.rawValued(),
            params: parameters,
            success: { response, headers in
                AuthenticationServices.saveUserSession(fromResponse: response, headers: headers)
                success(UserDataManager.currentUser)
            },
            failure: failure
        )
    }
    
    class func logout(
        success: @escaping () -> Void = {},
        failure: @escaping (_ error: Error) -> Void = { _ in }
    ) {
        let url = Network.Onboarding.logout.rawValued()
        APIClient.request(
            .delete,
            url: url,
            success: { _, _ in
                deleteSession()
                success()
            },
            failure: failure
        )
    }
    
    class func deleteAccount(
        success: @escaping () -> Void = {},
        failure: @escaping (_ error: Error) -> Void = { _ in }
    ) {
        let url = Network.Onboarding.logout.rawValued()
        APIClient.request(
            .delete,
            url: url,
            success: { _, _ in
                deleteSession()
                success()
            },
            failure: failure
        )
    }
    
    class func deleteSession() {
        UserDataManager.deleteUser()
        SessionManager.deleteSession()
    }
    
    class func saveUserSession(
        fromResponse response: [String: Any],
        headers: [AnyHashable: Any]
    ) {
        UserDataManager.currentUser = User(
            dictionary: response["user"] as? [String: Any] ?? [:]
        )
        if let headers = headers as? [String: Any] {
            SessionManager.currentSession = Session(headers: headers)
        }
    }
}
