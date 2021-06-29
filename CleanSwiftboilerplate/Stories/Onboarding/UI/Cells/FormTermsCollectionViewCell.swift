//
//  File.swift
//  CleanSwiftboilerplate
//
//  Created by Farhan Amjad on 29.06.21.
//

import UIKit
import SafariServices


class FormTermsCollectionViewCell: UICollectionViewCell {

    private lazy var termsConditionsCheckBox: UIButton = {
        let view = UIButton(type: .custom)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage.init(named: "iconCheckboxOutlined"), for: .normal)
        view.setImage(UIImage.init(named: "iconCheckboxFilled"), for: .selected)
       // view.addTarget(self, action: #selector(toggleCheckboxSelection), for: .touchUpInside)
        view.setTitle("  I agree to the ", for: .normal)
        view.setTitleColor(UIColor(red: 0.329, green: 0.329, blue: 0.329, alpha: 1), for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return view
    }()
    
    
    
    private lazy var stackViewTermsAndConditions: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillProportionally
        
        let buttonTnC = UIButton(type: .system)
        buttonTnC.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 0 / 255, green: 194 / 255, blue: 255 / 255, alpha: 1),
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributedTitle = NSMutableAttributedString(string: " Terms and Conditions*",
                                                        attributes: attributes)
        buttonTnC.setAttributedTitle(attributedTitle, for: .normal)
        buttonTnC.addTarget(self, action: #selector(termsHandler(sender:)), for: .touchUpInside)
        
        view.addArrangedSubview(termsConditionsCheckBox)
        view.addArrangedSubview(buttonTnC)
        return view
    }()
    
    private var item: CheckBox?

    func bind(_ item: FormComponent) {
        guard let item = item as? CheckBox else { return }
        self.item = item
        setup(item: item)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeViews()
        item = nil
    }
    
    @objc func termsHandler(sender: UIButton) {
        if let url = URL(string: "https://www.facebook.com/terms.php"){
            // self.present(SFSafariViewController(url: url), animated: true, completion: nil)
        }
    }
    
}

private extension FormTermsCollectionViewCell {
    
    func setup(item: CheckBox) {
        
        termsConditionsCheckBox.addTarget(self, action: #selector(actionDidTap), for: .touchUpInside)
        contentView.addSubview(stackViewTermsAndConditions)
        
        NSLayoutConstraint.activate([
            stackViewTermsAndConditions.heightAnchor.constraint(equalToConstant: 44),
            stackViewTermsAndConditions.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewTermsAndConditions.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackViewTermsAndConditions.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackViewTermsAndConditions.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    @objc
    func actionDidTap() {
        //guard let item = item else { return }
        termsConditionsCheckBox.isSelected = !termsConditionsCheckBox.isSelected
    }
}
