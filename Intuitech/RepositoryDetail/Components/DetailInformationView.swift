//
//  DetailInformationView.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 11..
//

import UIKit

final class DetailInformationView: UIView {
    // MARK: - Views
    private let informationStackView = UIStackView()
    
    private var mainVerticalStackView: UIStackView = {
        let mainVerticalStackView = UIStackView()
        mainVerticalStackView.axis = .vertical
        mainVerticalStackView.spacing = Constants.mainVerticalStackViewSpacing
        return mainVerticalStackView
    }()
    
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: Constants.titleLableFontSize, weight: .semibold)
        titleLabel.textColor = .secondaryLabel
        return titleLabel
    }()
    
    private var informationContainerView: UIView = {
        let informationContainerView = UIView()
        informationContainerView.layer.cornerRadius = Constants.informationContainerViewCornerRadius
        informationContainerView.backgroundColor = .tertiarySystemGroupedBackground
        return informationContainerView
    }()
    
    private var informationLabel: UILabel = {
        let informationLabel = UILabel()
        informationLabel.numberOfLines = .zero
        return informationLabel
    }()

    // MARK: - Init
    init(title: String, information: String) {
        titleLabel.text = Constants.titleLabelPrefix + title
        informationLabel.text = information
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Private functions
private extension DetailInformationView {
    func addSubviews() {
        addSubview(mainVerticalStackView)
        informationStackView.addArrangedSubview(informationContainerView)
        informationStackView.addArrangedSubview(UIView())
        informationContainerView.addSubview(informationLabel)
        mainVerticalStackView.addArrangedSubview(titleLabel)
        mainVerticalStackView.addArrangedSubview(informationStackView)
    }
    
    func setupConstraints() {
        mainVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // mainVerticalStackView
            mainVerticalStackView.topAnchor.constraint(equalTo: topAnchor),
            mainVerticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainVerticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.mainVerticalStackViewHorizontalPadding),
            mainVerticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.mainVerticalStackViewHorizontalPadding),
            
            // informationLabel
            informationLabel.topAnchor.constraint(equalTo: informationContainerView.topAnchor, constant: Constants.informationLabelPadding),
            informationLabel.bottomAnchor.constraint(equalTo: informationContainerView.bottomAnchor, constant: -Constants.informationLabelPadding),
            informationLabel.leadingAnchor.constraint(equalTo: informationContainerView.leadingAnchor, constant: Constants.informationLabelPadding),
            informationLabel.trailingAnchor.constraint(equalTo: informationContainerView.trailingAnchor, constant: -Constants.informationLabelPadding),
        ])
    }
}

// MARK: - Constants
private enum Constants {
    static let titleLabelPrefix = " - "
    static let mainVerticalStackViewSpacing: CGFloat = 8
    static let mainVerticalStackViewHorizontalPadding: CGFloat = 16
    static let informationContainerViewCornerRadius: CGFloat = 12
    static let informationLabelPadding: CGFloat = 12
    static let titleLableFontSize: CGFloat = 15
}
