//
//  StarCounterView.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 07..
//

import UIKit

final class StarCounterView: UIView {
    // MARK: - Views
    private var backgroundHorizontalStackView: UIStackView = {
        let backgroundHorizontalStackView = UIStackView()
        return backgroundHorizontalStackView
    }()
    
    private var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.layer.cornerRadius = Constants.backgroundViewCornerRadius
        backgroundView.backgroundColor = Constants.backgroundViewColor
        return backgroundView
    }()
    
    private var mainHorizontalStackView: UIStackView = {
        let mainHorizontalStackView = UIStackView()
        mainHorizontalStackView.distribution = .fill
        mainHorizontalStackView.alignment = .leading
        mainHorizontalStackView.spacing = Constants.mainHorizontalStackViewSpacing
        return mainHorizontalStackView
    }()
    
    private var starsLabel: UILabel = {
        let starsLabel = UILabel()
        starsLabel.font = .systemFont(ofSize: Constants.starsLabelFontSize)
        starsLabel.textColor = .black
        return starsLabel
    }()
    
    private var starsImageView: UIImageView = {
        let starsImageView = UIImageView()
        starsImageView.image = Constants.starImage
        starsImageView.tintColor = .black
        return starsImageView
    }()

    // MARK: - Init
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Internal API
extension StarCounterView {
    func setup(with number: Int) {
        starsLabel.text = String(describing: number)
    }
}

// MARK: - Private functions
private extension StarCounterView {
    func addSubviews() {
        addSubview(backgroundHorizontalStackView)
        backgroundHorizontalStackView.addArrangedSubview(backgroundView)
        backgroundHorizontalStackView.addArrangedSubview(UIView())
        backgroundView.addSubview(mainHorizontalStackView)
        mainHorizontalStackView.addArrangedSubview(starsLabel)
        mainHorizontalStackView.addArrangedSubview(starsImageView)
    }
    
    func setupConstraints() {
        backgroundHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        mainHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        starsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        starsLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        starsImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        starsImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            // backgroundHorizontalStackView
            backgroundHorizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            backgroundHorizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundHorizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundHorizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            // mainHorizontalStackView
            mainHorizontalStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: Constants.mainHorizontalStackViewPadding),
            mainHorizontalStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -Constants.mainHorizontalStackViewPadding),
            mainHorizontalStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: Constants.mainHorizontalStackViewPadding),
            mainHorizontalStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -Constants.mainHorizontalStackViewPadding),
            
            // starsImageView
            starsImageView.widthAnchor.constraint(equalToConstant: Constants.starImageSize),
            starsImageView.heightAnchor.constraint(equalToConstant: Constants.starImageSize)
        ])
    }
}

// MARK: - Constants
private enum Constants {
    static let backgroundViewCornerRadius: CGFloat = 16
    static let backgroundViewColor: UIColor = UIColor(named: "starCounterBackgroundColor") ?? .systemYellow
    static let mainHorizontalStackViewSpacing: CGFloat = 4
    static let mainHorizontalStackViewPadding: CGFloat = 8
    static let starsLabelFontSize: CGFloat = 14
    static let starImage: UIImage? = UIImage(systemName: "star.fill")
    static let starImageSize: CGFloat = 18
}
