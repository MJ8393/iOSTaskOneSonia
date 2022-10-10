//
//  MainViewController.swift
//  1SONIAiOSTask
//
//  Created by Mekhriddin Jumaev on 10/10/22.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {
    
    // MARK: Properties
    
    var viewModel = WeatherViewModel()
    
    // MARK: Outlets
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: ViewController Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addSubviews()
        setConstraints()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchCharactersFromDatabase()
    }
    
    // MARK: Actions
    
    @objc func deleteButtonTapped() {
        DataPersistanceManager.shared.deleteAllCharactersFromDatabase(characters: viewModel.characters!) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case.success():
                self.viewModel.page = 1
                self.viewModel.fetchCharactersFromDatabase()
                self.showAlert()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: Function
    
    func setupBinding(){
        viewModel.charactersDidChange = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.loadingDidChange = {
            if let isLoading = self.viewModel.isLoading {
                isLoading ? self.showLoadingView() : self.dissmissLoadingView()
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        // Do pagination when you scroll to the bottom
        if offsetY > contentHeight - height && !viewModel.disablePagenation {
            viewModel.page += 1
            viewModel.getCharacters(page: viewModel.page)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Main Screen"
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped))
        navigationItem.rightBarButtonItem = deleteButton
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Core Data is clear", message: "All the characters saved to core data were succusfully deleted", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }

    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view)
        }
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.setData(character: viewModel.characters![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        open(url: Endpoints.baseURL)
    }
}
