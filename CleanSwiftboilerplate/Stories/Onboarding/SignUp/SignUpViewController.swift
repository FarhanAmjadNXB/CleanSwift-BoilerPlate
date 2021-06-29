//
//  LoginViewController.swift
//  CleanSwiftboilerplate
//
//  Created by Farhan Amjad on 29.06.21.
//

import UIKit
import Combine

class SignUpViewController: AppBaseViewController {
    
    private lazy var formContentBuilder = FormContentBuilderImpl()
    private lazy var formCompositionalLayout = FormCompositionalLayout()
    private lazy var dataSource = makeDataSource()
    
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var collectionVw: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: formCompositionalLayout.layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.cellId)
      cv.register(FormButtonCollectionViewCell.self, forCellWithReuseIdentifier: FormButtonCollectionViewCell.cellId)
        cv.register(FormTextCollectionViewCell.self, forCellWithReuseIdentifier: FormTextCollectionViewCell.cellId)
       cv.register(FormTermsCollectionViewCell.self, forCellWithReuseIdentifier: FormTermsCollectionViewCell.cellId)
        return cv
    }()
        
    override func loadView() {
        super.loadView()
        setup()
        updateDataSource()
    }
}

private extension SignUpViewController {
    
    func updateDataSource(animated: Bool = false) {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self else { return }
            
            var snapshot = NSDiffableDataSourceSnapshot<FormSectionComponent, FormComponent>()
            
            let formSections = self.formContentBuilder.formContent
            snapshot.appendSections(formSections)
            formSections.forEach { snapshot.appendItems($0.items, toSection: $0) }
            
            self.dataSource.apply(snapshot, animatingDifferences: animated)
        }
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<FormSectionComponent, FormComponent> {
        
        return UICollectionViewDiffableDataSource(collectionView: collectionVw) { [weak self] collectionVw, indexPath, item in
            
            guard let self = self else {
                let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
                return cell
            }
            
            switch item {
            case is TextFormComponent:
                let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: FormTextCollectionViewCell.cellId,
                                                            for: indexPath) as! FormTextCollectionViewCell
                
                cell.subject
                    .sink { [weak self] val, indexPath in
                        self?.formContentBuilder.update(val: val, at: indexPath)
                    }
                cell.bind(item, at: indexPath)
                return cell
            case is ButtonFormItem:
                let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: FormButtonCollectionViewCell.cellId,
                                                            for: indexPath) as! FormButtonCollectionViewCell
                cell.bind(item)
                return cell
                
            case is  CheckBox:
                let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: FormTermsCollectionViewCell.cellId,
                                                            for: indexPath) as! FormTermsCollectionViewCell
                cell.bind(item)
                return cell
            default:
                let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
                return cell
            }
        }
    }
}

private extension SignUpViewController {
    
    func setup() {

        view.backgroundColor = .white
        
        // Setup CollectionView
        
        collectionVw.dataSource = dataSource
        
        // Layout
        
        view.addSubview(collectionVw)
        
        NSLayoutConstraint.activate([
            collectionVw.topAnchor.constraint(equalTo: view.topAnchor),
            collectionVw.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionVw.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionVw.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
