//
//  UserTableViewCell.swift
//  UserListDemo
//
//  Created by Yevhen Triukhan on 06.10.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

import Kingfisher

enum EmptyCellEvent {
    
}

class UserTableViewCell: BaseCell<UserViewData, EmptyCellEvent> {

    // MARK: - Subtypes
    
    private enum Constant {
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 1
    }
    
    // MARK: - Properties
    
    @IBOutlet var contentContainerView: UIView?
    
    @IBOutlet var userNameLabel: UILabel?
    @IBOutlet var userEmailLabel: UILabel?
    @IBOutlet var userPhotoImageView: UIImageView?
    
    private var downloadTask: DownloadTask?
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.reset()
    }
    
    // MARK: - Public
    
    public override func fill(with model: UserViewData) {
        self.userNameLabel?.text = model.fullName
        self.userEmailLabel?.text = model.email
        
        let placeholder = UIImage(named: "userphoto_placeholder_image")
        self.downloadTask = self.userPhotoImageView?.kf
            .setImage(with: model.photoURL, placeholder: placeholder)
    }
    
    // MARK: - Private
    
    private func reset() {
        self.userNameLabel?.text = nil
        self.userEmailLabel?.text = nil
        self.userPhotoImageView?.image = nil
        self.downloadTask?.cancel()
    }
    
    private func configure() {
        self.contentContainerView?
            .set(cornerRadius: Constant.cornerRadius)
            .set(borderWidth: Constant.borderWidth)
            .set(borderColor: .label)
        
        self.userPhotoImageView?
            .set(cornerRadius: Constant.cornerRadius)
    }
}
