//
//  Sortyboard+Extension.swift


import UIKit
extension UIStoryboard {
    /// Main storyboard
    public var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    public var home: UIStoryboard {
        return UIStoryboard(name: "Home", bundle: nil)
    }
    
    /// Instantiates and returns the view controller with the specified identifier.
    ///
    /// - Parameter identifier: uniquely identifies equals to Class name
    /// - Returns: The view controller corresponding to the specified identifier string. If no view controller is associated with the string, this method throws an exception.
    public func instantiateViewController<T>(withIdentifier identifier: T.Type) -> T where T: UIViewController {
        let className = String(describing: identifier)
        guard let vc =  self.instantiateViewController(withIdentifier: className) as? T else {
            fatalError("Cannot find controller with identifier \(className)")
        }
        return vc
    }
}
