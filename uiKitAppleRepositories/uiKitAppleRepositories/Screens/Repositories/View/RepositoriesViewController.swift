import UIKit
import Combine

class RepositoriesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var errorInfoLabel: UILabel!
    @IBOutlet var tryAgainButton: UIButton!

    private let viewModel: RepositoriesViewModel

    private var bindings = Set<AnyCancellable>()

    init?(coder: NSCoder, viewModel: RepositoriesViewModel) {
        self.viewModel = viewModel

        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:viewModel:)` to instantiate.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        bindViewModelToView()
        viewModel.fetchAllAppleRepositories()
    }

    func initView() {
        tableView.accessibilityIdentifier = "appleTableView"
        activityIndicatorView.accessibilityIdentifier = "appleActivityIndicator"
    }

    func reloadTableView() {
        tableView.reloadData()
    }

    func startLoading() {
        tableView.isHidden = true
        tryAgainButton.isHidden = true
        errorInfoLabel.isHidden = true
        activityIndicatorView.startAnimating()
    }

    func finishLoading() {
        tableView.fadeIn()

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
    
    private func bindViewModelToView() {
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

// MARK: - UITableViewDataSource

extension RepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allRepositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.identifier, for: indexPath) as? RepositoryCell else { fatalError("\(RepositoryCell.identifier) does not exists")
        }

        cell.repository = viewModel.allRepositories[indexPath.row]

        return cell
    }
}
