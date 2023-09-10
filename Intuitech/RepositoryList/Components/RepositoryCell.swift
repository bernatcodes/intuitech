//
//  RepositoryCell.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 06..
//

import UIKit

final class RepositoryCell: UITableViewCell {
    // MARK: - Views
    private var roundedBackgroundView: UIView = {
        let roundedBackgroundView = UIView()
        roundedBackgroundView.layer.cornerRadius = Constants.roundedBackgroundViewCornerRadius
        roundedBackgroundView.backgroundColor = .tertiarySystemGroupedBackground
        return roundedBackgroundView
    }()
    
    private var mainVerticalStackView: UIStackView = {
        let mainVerticalStackView = UIStackView()
        mainVerticalStackView.axis = .vertical
        mainVerticalStackView.spacing = Constants.mainVerticalStackViewSpacing
        return mainVerticalStackView
    }()
    
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: Constants.titleFontSize, weight: .semibold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = .zero
        return titleLabel
    }()
    
    private var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = .zero
        return descriptionLabel
    }()
    
    private var starCounterView: StarCounterView = {
        let starCounterView = StarCounterView()
        return starCounterView
    }()
    
    private var updateDateLabel: UILabel = {
        let updateDateLabel = UILabel()
        updateDateLabel.font = .systemFont(ofSize: Constants.updateDateLabelFontSize)
        updateDateLabel.textColor = .secondaryLabel
        updateDateLabel.textAlignment = .right
        return updateDateLabel
    }()
    
    private var chevronImageView: UIImageView = {
        let chevronImageView = UIImageView()
        chevronImageView.image = UIImage(systemName: Constants.chevronRightImage)
        chevronImageView.tintColor = .secondaryLabel
        return chevronImageView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            roundedBackgroundView.backgroundColor = .tertiaryLabel
        } else {
            roundedBackgroundView.backgroundColor = .tertiarySystemGroupedBackground
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            roundedBackgroundView.backgroundColor = .tertiaryLabel
        } else {
            roundedBackgroundView.backgroundColor = .tertiarySystemGroupedBackground
        }
    }
}

// MARK: - Internal API
extension RepositoryCell {
    func setupCell(with model: Repository) {
        titleLabel.text = model.name
        descriptionLabel.text = model.description?.shortened(to: Constants.characterLimit)
        starCounterView.setup(with: model.stars)
        updateDateLabel.text = model.lastUpdated
    }
}

// MARK: - Private functions
private extension RepositoryCell {
    func addSubviews() {
        contentView.addSubview(roundedBackgroundView)
        roundedBackgroundView.addSubview(mainVerticalStackView)
        roundedBackgroundView.addSubview(chevronImageView)
        mainVerticalStackView.addArrangedSubview(titleLabel)
        mainVerticalStackView.addArrangedSubview(descriptionLabel)
        mainVerticalStackView.addArrangedSubview(starCounterView)
        mainVerticalStackView.addArrangedSubview(updateDateLabel)
    }
    
    func setupConstraints() {
        roundedBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        mainVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // roundedBackgroundView
            roundedBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.roundedBackgroundViewVerticalPadding),
            roundedBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.roundedBackgroundViewVerticalPadding),
            roundedBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.roundedBackgroundViewHorizontalPadding),
            roundedBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.roundedBackgroundViewHorizontalPadding),
            
            // mainVerticalStackView
            mainVerticalStackView.topAnchor.constraint(equalTo: roundedBackgroundView.topAnchor, constant: Constants.mainVerticalStackViewPadding),
            mainVerticalStackView.bottomAnchor.constraint(equalTo: roundedBackgroundView.bottomAnchor, constant: -Constants.mainVerticalStackViewPadding),
            mainVerticalStackView.leadingAnchor.constraint(equalTo: roundedBackgroundView.leadingAnchor, constant: Constants.mainVerticalStackViewPadding),
            
            // chevronImageView
            chevronImageView.widthAnchor.constraint(equalToConstant: Constants.chevronImageViewWidth),
            chevronImageView.heightAnchor.constraint(equalToConstant: Constants.chevronImageViewHeight),
            chevronImageView.centerYAnchor.constraint(equalTo: mainVerticalStackView.centerYAnchor),
            chevronImageView.leadingAnchor.constraint(equalTo: mainVerticalStackView.trailingAnchor,
                                                      constant: Constants.chevronImageViewLeadingPadding),
            chevronImageView.trailingAnchor.constraint(equalTo: roundedBackgroundView.trailingAnchor,
                                                       constant: Constants.chevronImageViewTrailingPadding)
        ])
    }
}

// MARK: - Constants
private enum Constants {
    static let roundedBackgroundViewCornerRadius: CGFloat = 12
    static let titleFontSize: CGFloat = 22
    static let updateDateLabelFontSize: CGFloat = 14
    static let roundedBackgroundViewVerticalPadding: CGFloat = 8
    static let roundedBackgroundViewHorizontalPadding: CGFloat = 16
    static let mainVerticalStackViewSpacing: CGFloat = 8
    static let mainVerticalStackViewPadding: CGFloat = 16
    static let chevronImageViewWidth: CGFloat = 12
    static let chevronImageViewHeight: CGFloat = 20
    static let chevronImageViewLeadingPadding: CGFloat = 8
    static let chevronImageViewTrailingPadding: CGFloat = -24
    static let characterLimit: Int = 300
    static let chevronRightImage: String = "chevron.right"
}
