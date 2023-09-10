//
//  RepositoryDetailViewController.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 08..
//

import UIKit

final class RepositoryDetailViewController: UIViewController {
    // MARK: - Properties
    private let repository: Repository
    
    // MARK: - Views
    private let footerView = UIView()
    
    private var containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()
    
    // MARK: - Init
    init(repository: Repository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Private functions
private extension RepositoryDetailViewController {
    func setupView() {
        title = repository.name
        view.backgroundColor = .systemBackground
        addSubviews()
        addArrangedSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    func addArrangedSubviews() {
        stackView.addArrangedSubview(AvatarWithLinkView(imageUrl: repository.ownerAvatarUrl,
                                                        profileUrl: repository.ownerProfileUrl,
                                                        repositoryUrl: repository.url))
        stackView.addArrangedSubview(DetailInformationView(title: LocalizedKeys.repositoryDetailOwnerNameTitle,
                                                           information: repository.ownerName))
        if let description = repository.description {
            stackView.addArrangedSubview(DetailInformationView(title: LocalizedKeys.repositoryDetailDescriptionTitle,
                                                               information: description))
        }
        stackView.addArrangedSubview(DetailInformationView(title: LocalizedKeys.repositoryDetailNumberOfStarsTitle,
                                                           information: String(describing: repository.stars)))
        stackView.addArrangedSubview(DetailInformationView(title: LocalizedKeys.repositoryDetailNumberOfForksTitle,
                                                           information: String(describing: repository.forks)))
        if let createdAt = repository.createdAt {
            stackView.addArrangedSubview(DetailInformationView(title: LocalizedKeys.repositoryDetailCreatedAtTitle,
                                                               information: createdAt))
        }
        if let lastUpdated = repository.lastUpdated {
            stackView.addArrangedSubview(DetailInformationView(title: LocalizedKeys.repositoryDetailUpdatedAtTitle,
                                                               information: lastUpdated))
        }
        stackView.addArrangedSubview(footerView)
    }
    
    func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // containerView
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // scrollView
            scrollView.topAnchor.constraint(equalTo: containerView.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            // stackView
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}

// MARK: - Constants
private enum Constants {
    static let stackViewSpacing: CGFloat = 20
}
