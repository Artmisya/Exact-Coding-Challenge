//
//  ContactListViewController.swift
//  Contact
//
//  Created by Saeedeh on 28/06/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
class AccountListViewController: BaseViewController {

    @IBOutlet var searchBarView: UISearchBar!
    @IBOutlet var accountsTableView: UITableView!

    let companyAccount = CompanyContact.sharedInstance
    private var accountList=[Account]()
    private var refreshControl = UIRefreshControl()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUpUi()
        configureTableView()
        configureRefreshControl()
        createSearchObserver()
        loadAccounts()
    }
    private func loadAccounts(){
        
        companyAccount.fetchAccounts(){ (result) in
            switch result{
            case .success(let data):
                
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.accountList=data
                    self.accountsTableView.reloadData()
                }
            case .failure(let error):
                print (error)
                self.handleError(error: error)
            }
        }
    }
    
    private func createSearchObserver(){
        
        searchBarView.rx.text.asObservable().subscribe(onNext: {
            (searchText) in
            // if search text is empty no need search just refresh
            if (searchText?.isEmpty)! {
                self.accountList=self.companyAccount.accountsList
                self.accountsTableView.reloadData()
                return
            }
            // go for search
            self.accountList = self.accountList.filter({
                
                return $0.search(searchKeyword: (searchText?.lowercased())!)
            })
            self.accountsTableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
   private func configureTableView() {
    
        self.accountsTableView.delegate = self
        self.accountsTableView.dataSource = self
    
        let nib = UINib(nibName: "AccountCell", bundle: nil)
        accountsTableView.register(nib, forCellReuseIdentifier: "AccountCell")
    
        accountsTableView.rowHeight = UITableViewAutomaticDimension
        accountsTableView.estimatedRowHeight = 200.0
    }
    
    private func setupUpUi(){
        
        self.title="Account Records"
        
        view.isUserInteractionEnabled=true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(recognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureRefreshControl(){
        
        refreshControl.addTarget(self, action: #selector(self.didPullToRefresh), for: .valueChanged)
        accountsTableView.addSubview(refreshControl)
        searchBarView.delegate=self
   
    }
    
    // dismiss keyboard when user tab on the view
    @objc func viewTapped(recognizer: UITapGestureRecognizer){
        
        print ("viewTapped")
        self.searchBarView.endEditing(true)
    }
    
    @objc func didPullToRefresh() {
        
        print ("didPullToRefresh")
        searchBarView.text=""
        loadAccounts()
    }
}

//****** MARK: tableview delegates

extension AccountListViewController:UITableViewDataSource, UITableViewDelegate  {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        print("accountsList.count=>>",self.accountList.count)

        return accountList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:AccountCell = tableView.dequeueReusableCell(withIdentifier: "AccountCell") as! AccountCell
        let account = self.accountList[indexPath.row]

        // setting the incomplete & mismatand color indicators:
        if account.isIncomplete(){
            
            cell.incompleteView.isHidden=false
            cell.incompleteView.backgroundColor=Constants.Account.ColorIndicator.incomplete
        }
        else{
            
            cell.incompleteView.isHidden=true
        }
        if account.isMismatched(){
            
            cell.mismatchView.isHidden=false
            cell.mismatchView.backgroundColor=Constants.Account.ColorIndicator.mismatch
        }
        else{
            
            cell.mismatchView.isHidden=true
        }
        
        cell.accountLabel.text = account.accountId
        cell.selectionStyle = UITableViewCellSelectionStyle.default
        
        return cell
    }
}

//****** MARK: UISearchBarDelegate

extension AccountListViewController:UISearchBarDelegate{
    
    // dismiss keyboard when user click on search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchBarView.endEditing(true)
    }
}

