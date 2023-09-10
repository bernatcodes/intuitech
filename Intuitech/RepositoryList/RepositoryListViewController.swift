//
//  RepositoryListViewController.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 06..
//

import UIKit

final class RepositoryListViewController: UIViewController {
    // MARK: - Internal properties
    let presenter: RepositoryPresenterProtocol
    
    // MARK: - Private properties
    private var selectedIndexPath: IndexPath? = nil
    private var shouldFetchMoreOnScroll: Bool = true
    private var isLoadingData: Bool = false {
        didSet {
            if isLoadingData {
                loadingIndicator.startAnimating()
            } else {
                loadingIndicator.stopAnimating()
            }
        }
    }
    
    // MARK: - Views
    private let footerView = UIView()
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    
    private var searchStackView: UIStackView = {
        let searchStackView = UIStackView()
        searchStackView.spacing = Constants.searchStackViewSpacing
        return searchStackView
    }()
    
    private var searchTextField: UISearchTextField = {
        let searchTextField = UISearchTextField()
        searchTextField.placeholder = LocalizedKeys.repositoryListSearchTextfieldPlaceholderText
        searchTextField.returnKeyType = .search
        searchTextField.autocorrectionType = .no
        return searchTextField
    }()
    
    private var searchButton: UIButton = {
        let searchButton = UIButton()
        searchButton.setTitle(LocalizedKeys.repositoryListSearchButtonTitle, for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.backgroundColor = .systemBlue
        searchButton.layer.cornerRadius = Constants.searchButtonCornerRadius
        return searchButton
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var tableViewStatusLabel: UILabel = {
        let tableViewStatusLabel = UILabel()
        tableViewStatusLabel.text = LocalizedKeys.repositoryListEmptyListTitle
        tableViewStatusLabel.textAlignment = .center
        tableViewStatusLabel.textColor = .secondaryLabel
        tableViewStatusLabel.numberOfLines = .zero
        return tableViewStatusLabel
    }()
    
    // MARK: - Init
    init(presenter: RepositoryPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let indexPath = selectedIndexPath else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndexPath = nil
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension RepositoryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.reuseKey, for: indexPath) as? RepositoryCell else { return UITableViewCell() }
        
        let model = presenter.repositories[indexPath.row]
        cell.setupCell(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        presenter.navigateToRepositoryDetail(of: indexPath.row)
        searchTextField.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndexPath = IndexPath(row: presenter.repositories.count - 1, section: .zero)
        if indexPath == lastIndexPath && !isLoadingData && shouldFetchMoreOnScroll {
            search()
        }
    }
}

// MARK: - UITextFieldDelegate
extension RepositoryListViewController: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search(shouldResetSearch: true)
        return true
    }
}

// MARK: - Internal API
extension RepositoryListViewController: RepositoryListViewProtocol {
    func displayRepositories(noMoreResult: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.updateTableView()
            self.updateStatusLabel()
            self.shouldFetchMoreOnScroll = !noMoreResult
        }
    }
    
    func displayError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.updateTableView()
            self.updateStatusLabel(isError: true)
        }
    }
    
    func resetTableViewData() {
        tableView.reloadData()
    }
}

// MARK: - Private functions
private extension RepositoryListViewController {
    func setupView() {
        title = LocalizedKeys.repositoryListTitle
        view.backgroundColor = .systemBackground
        
        searchTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .interactiveWithAccessory
        
        searchButton.addTarget(self, action: #selector(searchButtonAction), for: .touchUpInside)
        searchTextField.target(forAction: #selector(searchButtonAction), withSender: self)
        
        addSubviews()
        setupConstraints()
        registerTableViewCell()
    }
    
    func addSubviews() {
        view.addSubview(searchStackView)
        searchStackView.addArrangedSubview(searchTextField)
        searchStackView.addArrangedSubview(searchButton)
        view.addSubview(tableView)
        tableView.addSubview(tableViewStatusLabel)
        footerView.addSubview(loadingIndicator)
        tableView.tableFooterView = footerView
    }
    
    func setupConstraints() {
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableViewStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        footerView.frame = CGRect(x: .zero, y: .zero, width: tableView.frame.size.width, height: Constants.footerHeight)
        
        NSLayoutConstraint.activate([
            // searchTextField
            searchStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.searchStackViewTopPadding),
            searchStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.searchStackViewHorizontalPadding),
            searchStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.searchStackViewHorizontalPadding),
            searchStackView.heightAnchor.constraint(equalToConstant: Constants.searchStackViewHeight),
            
            // searchButton
            searchButton.widthAnchor.constraint(equalToConstant: Constants.searchButtonWidth),
            
            // tableView
            tableView.topAnchor.constraint(equalTo: searchStackView.bottomAnchor, constant: Constants.tableViewTopPadding),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // tableViewStatusLabel
            tableViewStatusLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            tableViewStatusLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            
            // loadingIndicator
            loadingIndicator.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
        ])
    }
    
    func registerTableViewCell() {
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.reuseKey)
    }
    
    @objc func searchButtonAction(sender: UIButton) {
        search(shouldResetSearch: true)
        searchTextField.resignFirstResponder()
    }
    
    func search(shouldResetSearch: Bool = false) {
        guard let searchText = searchTextField.text else { return }
        presenter.searchRepositories(withQuery: searchText, resetSearch: shouldResetSearch)
        searchTextField.resignFirstResponder()
        isLoadingData = true
        view.isUserInteractionEnabled = false
        updateStatusLabel()
    }
    
    func updateTableView() {
        isLoadingData = false
        tableView.reloadData()
        view.isUserInteractionEnabled = true
    }
    
    func updateStatusLabel(isError: Bool = false) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if isError {
                self.tableViewStatusLabel.text = LocalizedKeys.repositoryListErrorTitle
            } else if self.presenter.repositories.isEmpty {
                self.tableViewStatusLabel.text = LocalizedKeys.repositoryListNoRepositoriesFoundTitle
            }
            self.tableViewStatusLabel.isHidden = !self.presenter.repositories.isEmpty || self.isLoadingData
        }
    }
}

// MARK: - Constants
private enum Constants {
    static let searchStackViewSpacing: CGFloat = 12
    static let searchButtonCornerRadius: CGFloat = 8
    static let searchStackViewTopPadding: CGFloat = 8
    static let searchStackViewHorizontalPadding: CGFloat = 16
    static let searchStackViewHeight: CGFloat = 40
    static let searchButtonWidth: CGFloat = 80
    static let tableViewTopPadding: CGFloat = 8
    static let footerHeight: CGFloat = 100
}
