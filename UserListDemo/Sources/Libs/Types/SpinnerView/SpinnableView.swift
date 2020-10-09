//
//  SpinnableView.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 09.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

// Just a container for SpinnerView

class SpinnableView<ViewModel: UnlockHandable>: BaseView<ViewModel> {
    
    // MARK: - Init and Deinit
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.configure()
    }
    // MARK: - Properties

    var spinnerView = SpinnerView()

    // MARK: - Public
    
    override func fill(with viewModel: ViewModel) {
        super.fill(with: viewModel)
        
        viewModel.lockHandler = { [weak self] in self?.lock() }
        viewModel.unlockHandler = { [weak self] in self?.unlock() }
    }
    
    func lock() {
        DispatchQueue.main.async { [weak self] in
            self?.spinnerView.indicator?.startAnimating()
            self?.spinnerView.show()
        }
    }

    func unlock(_ completion: EmptyAction? = nil) {
        DispatchQueue.main.async { [weak self] in
            self?.spinnerView.indicator?.stopAnimating()
            self?.spinnerView.hide()
            completion?()
        }
    }
    
    // MARK: - Private
    
    private func configure() {
        let spinnerView = self.spinnerView
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spinnerView)
        
        NSLayoutConstraint.activate([
            spinnerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            spinnerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            spinnerView.topAnchor.constraint(equalTo: self.topAnchor),
            spinnerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        spinnerView.isHidden = true
    }
}

