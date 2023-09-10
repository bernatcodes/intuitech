//
//  AvatarWithLinkView.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 11..
//

import UIKit

final class AvatarWithLinkView: UIView {
    // MARK: - Private properties
    private let imageUrl: URL?
    private let profileUrl: URL?
    private let repositoryUrl: URL?
    
    // MARK: - Views
    private var mainHorizontalStackView: UIStackView = {
        let mainHorizontalStackView = UIStackView()
        mainHorizontalStackView.spacing = Constants.mainHorizontalStackViewSpacing
        mainHorizontalStackView.alignment = .center
        return mainHorizontalStackView
    }()
    
    private var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderWidth = Constants.avatarImageViewBorderWidth
        avatarImageView.layer.borderColor = UIColor.tertiarySystemGroupedBackground.inverted.cgColor
        avatarImageView.image = UIImage(
            systemName: Constants.defaultProfileImage
        )?.withTintColor(.label, renderingMode: .alwaysOriginal)
        return avatarImageView
    }()
    
    private var repositoryLinkButton: UIButton = {
        let linkButton = UIButton()
        linkButton.setImage(UIImage(systemName: Constants.repositoryButtonImage),
                            for: .normal)
        linkButton.contentVerticalAlignment = .fill
        linkButton.contentHorizontalAlignment = .fill
        linkButton.imageEdgeInsets = UIEdgeInsets(top: .zero,
                                                  left: .zero,
                                                  bottom: .zero,
                                                  right: .zero)
        return linkButton
    }()
    
    private var profileLinkButton: UIButton = {
        let linkButton = UIButton()
        linkButton.setImage(UIImage(systemName: Constants.profileButtonImage),
                            for: .normal)
        linkButton.contentVerticalAlignment = .fill
        linkButton.contentHorizontalAlignment = .fill
        linkButton.imageEdgeInsets = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
        return linkButton
    }()
    
    // MARK: - Init
    init(imageUrl: URL?, profileUrl: URL?, repositoryUrl: URL?) {
        self.imageUrl = imageUrl
        self.profileUrl = profileUrl
        self.repositoryUrl = repositoryUrl
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *) {
            avatarImageView.layer.borderColor = UIColor.tertiarySystemGroupedBackground.inverted.cgColor
        }
    }
}

// MARK: - Private functions
private extension AvatarWithLinkView {
    func setupView() {
        addSubviews()
        setupConstraints()
        setupAvatarImageView()
        
        profileLinkButton.addTarget(self, action: #selector(openProfileUrl), for: .touchUpInside)
        repositoryLinkButton.addTarget(self, action: #selector(openRepositoryUrl), for: .touchUpInside)
    }
    
    func addSubviews() {
        addSubview(mainHorizontalStackView)
        mainHorizontalStackView.addArrangedSubview(profileLinkButton)
        mainHorizontalStackView.addArrangedSubview(avatarImageView)
        mainHorizontalStackView.addArrangedSubview(repositoryLinkButton)
    }
    
    func setupConstraints() {
        mainHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        repositoryLinkButton.translatesAutoresizingMaskIntoConstraints = false
        profileLinkButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // mainHorizontalStackView
            mainHorizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.mainHorizontalStackViewVerticalPadding),
            mainHorizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.mainHorizontalStackViewVerticalPadding),
            mainHorizontalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // avatarImageView
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.avatarImageSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatarImageSize),
            
            // repositoryLinkButton
            repositoryLinkButton.widthAnchor.constraint(equalToConstant: Constants.commonButtonSize),
            repositoryLinkButton.heightAnchor.constraint(equalToConstant: Constants.commonButtonSize),
            
            // profileLinkButton
            profileLinkButton.widthAnchor.constraint(equalToConstant: Constants.commonButtonSize),
            profileLinkButton.heightAnchor.constraint(equalToConstant: Constants.commonButtonSize),
        ])
    }
    
    func setupAvatarImageView() {
        guard let imageUrl = imageUrl else { return }
        avatarImageView.frame = CGRect(x: .zero,
                                       y: .zero,
                                       width: Constants.avatarImageSize,
                                       height: Constants.avatarImageSize)
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        avatarImageView.fetchImage(from: imageUrl)
    }
    
    @objc func openProfileUrl() {
        guard let url = profileUrl else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func openRepositoryUrl() {
        guard let url = repositoryUrl else { return }
        UIApplication.shared.open(url)
    }
}

// MARK: - Constants
private enum Constants {
    static let mainHorizontalStackViewSpacing: CGFloat = 8
    static let mainHorizontalStackViewVerticalPadding: CGFloat = 12
    static let avatarImageViewBorderWidth: CGFloat = 3
    static let defaultProfileImage = "person.circle"
    static let repositoryButtonImage = "folder.circle"
    static let profileButtonImage = "link.circle"
    static let avatarImageSize: CGFloat = 180
    static let commonButtonSize: CGFloat = 45
}
