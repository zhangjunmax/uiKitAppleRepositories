import UIKit
import Combine

class RepositoriesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var errorInfoLabel: UILabel!
    @IBOutlet var tryAgainButton: UIButton!

    lazy var viewModel = {
        RepositoriesViewModel()
    }()

    private var bindings = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
        bindViewModelToView()
        viewModel.fetchAllAppleRepositories()
    }

    func initView() {
        tableView.accessibilityIdentifier = "appleTableView"
        activityIndicatorView.accessibilityIdentifier = "appleActivityIndicator"
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        tableView.rowHeight = UITableView.automaticDimension
//             tableView.estimatedRowHeight = 120
//
////        tableView.register(RepositoryCell.nib, forCellReuseIdentifier: RepositoryCell.identifier)
    }

    func initViewModel() {
        // Get employees data
//        viewModel.getEmployees()
//
//        // Reload TableView closure
//        viewModel.reloadTableView = { [weak self] in
//            DispatchQueue.main.async {
//                self?.tableView.reloadData()
//            }
//        }
    }

    func reloadTableView() {
        tableView.reloadData()
    }

    func startLoading() {
        print("startLoading")

        tableView.isHidden = true
        tryAgainButton.isHidden = true
        errorInfoLabel.isHidden = true
        activityIndicatorView.startAnimating()
    }

    func finishLoading() {
        print("finishLoading")

        tableView.isHidden = false
        activityIndicatorView.stopAnimating()
    }

    @IBAction func tryAgainTapped(_ sender: UIButton) {

        viewModel.fetchAllAppleRepositories()
    }

    private func showError(_ error: Error) {
        tableView.isHidden = true
        tryAgainButton.isHidden = false
        errorInfoLabel.isHidden = false
    }
    
    func bindViewModelToView() {
        viewModel.$allRepositories
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.reloadTableView()
            })
            .store(in: &bindings)

        let stateValueHandler: (RemoteContentLoadingState) -> Void = { [weak self] state in
            switch state {
            case .loading:
                self?.startLoading()
            case .finishedLoading:
                self?.finishLoading()
            case .error(let error):
                self?.finishLoading()
                self?.showError(error)
            }
        }

        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &bindings)
    }
}

// MARK: - UITableViewDelegate

extension RepositoriesViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 130
//    }
}

// MARK: - UITableViewDataSource

extension RepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allRepositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.identifier, for: indexPath) as? RepositoryCell else { fatalError("xib does not exists") }
//        let cellVM = viewModel.getCellViewModel(at: indexPath)
//        cell.cellViewModel = cellVM

        cell.repository = viewModel.allRepositories[indexPath.row]

        return cell
    }
}
