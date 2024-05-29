//
//  ListingViewController.swift
//  contact
//
//  Created by Siti Norain Ishak on 29/05/2024.
//

import UIKit
import RxSwift
import RxCocoa

class ListingViewController: TableViewController {
    
    private let disposeBag = DisposeBag()
    private let cell = ListingTableViewCell.fromXib()
    private let refreshControl = UIRefreshControl()
    
    var viewModel: ListingViewModel!
    
    static func fromStoryboard() -> ListingViewController {
        let viewController = R.storyboard.listing.instantiateInitialViewController()!
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func configureViews() {
        navigationItem.hidesBackButton = true
        navigationItem.title = "Contacts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonOnSelected(_:)))
        
        tableView.register(cell.cellNib, forCellReuseIdentifier: cell.reuseIdentifier)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        if #available(iOS 10, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    private func setupObserver() {
        viewModel.contacts
            .bind(to: tableView
                    .rx
                    .items(cellIdentifier: cell.reuseIdentifier,
                           cellType: ListingTableViewCell.self)) { row, contact, cell in
                cell.refreshViews(firstName: contact.firstName, lastName: contact.lastName)
            }
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .modelSelected(Contact.self)
            .subscribe(onNext: { [weak self] contact in
                if let selectedRowIndexPath = self?.tableView.indexPathForSelectedRow {
                    self?.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
                self?.didSelectedContact(contact)
            })
            .disposed(by: disposeBag)
        
        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.loadInitialData()
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .map { _ in self.refreshControl.isRefreshing }
            .filter { $0 == true }
            .subscribe { [weak self] _ in
                self?.refreshControl.endRefreshing()
            }
            .disposed(by: disposeBag)
    }
    
    @objc private func addButtonOnSelected(_ sender: UIBarButtonItem) {
        viewModel.navigateToDetailsView(from: self)
    }
    
    private func didSelectedContact(_ contact: Contact) {
        viewModel.navigateToDetailsView(from: self, withSelectedContact: contact)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
