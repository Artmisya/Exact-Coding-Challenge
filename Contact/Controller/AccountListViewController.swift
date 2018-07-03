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
import SVProgressHUD
class AccountListViewController: BaseViewController {

    @IBOutlet var searchBarView: UISearchBar!
    @IBOutlet var accountsTableView: UITableView!
    @IBOutlet var alertLabel: UILabel!
    @IBOutlet var alertView: UIView!

    let searchText = Variable<String?>(nil)
     private let disposeBag = DisposeBag()
    
    let dataRecord = DataRecord.sharedInstance
    private var accountList=[Account]()
    private var refreshControl = UIRefreshControl()

   

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureTableView()
        configureRefreshControl()
        createSearchObserver()
        loadAccounts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshData()
    }
    
    private func refreshData(){
        
        accountList=dataRecord.accountsList
        self.accountsTableView.reloadData()
        // make searchText.observable to get called
        if searchBarView.text != "" {
            searchText.value = searchBarView.text
        }
    }
    private func loadAccounts(){
        
        SVProgressHUD.show(withStatus: "loading...")
                dataRecord.fetchAccounts(){ (result) in
            switch result{
            case .success(let data):
                
                DispatchQueue.main.async {
                    
                    self.refreshControl.endRefreshing()
                    self.accountList=data
                    self.accountsTableView.reloadData()
                    SVProgressHUD.dismiss()
                }
            case .failure(let error):
                print (error)
                self.handleError(error: error)
            }
        }
    }
    
    private func createSearchObserver(){
        
        searchText.asObservable().subscribe(onNext: { [weak self] (text) in
            if let welf = self, welf.searchBarView.text != text {
                welf.searchBarView.text = text
            }
        }).disposed(by: disposeBag)
        
        searchText.asObservable().subscribe({[weak self] (text) in
            
            if let searchText=self?.searchText.value{
                self?.accountList = (self?.accountList.filter({
                    
                    return $0.search(searchKeyword:searchText)
                }))!
                self?.accountsTableView.reloadData()
            }
        }).disposed(by: disposeBag)
  
        searchBarView.rx.text.asDriver()
            .drive(searchText)
            .disposed(by: disposeBag)
        
        searchBarView.rx.text.asObservable().subscribe(onNext: { [weak self]
            (searchText) in
            // if search text is empty no need search just reset the datasource
            if (searchText?.isEmpty)! {
                //reset datasource
                self?.accountList=(self?.dataRecord.accountsList)!
                self?.accountsTableView.reloadData()
                return
            }
            // go for search
            self?.accountList = (self?.accountList.filter({
                
                return $0.search(searchKeyword:searchText!)
            }))!
            self?.accountsTableView.reloadData()
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
    
    private func configureUI(){
        
        self.title="Account Records"
        
        view.isUserInteractionEnabled=true
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(recognizer:)))
//        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureRefreshControl(){
        
        refreshControl.addTarget(self, action: #selector(self.didPullToRefresh), for: .valueChanged)
        accountsTableView.addSubview(refreshControl)
        searchBarView.delegate=self
    }
    
    func confirmRemoveAccount(account:Account){
        
        let alert = UIAlertController(title: "", message: Constants.DataRecord.Message.deleteAccountAlert, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.removeAccount(account:account)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
            return
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func removeAccount(account:Account){
        
        let result=dataRecord.removeAccount(account:account)
        
        switch result {
        case .success(_):
            
            refreshData()
            alertLabel.text=Constants.DataRecord.Message.deleteAccountSuccess
            alertView.isHidden = false
            let when = DispatchTime.now() + 1.0
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.alertView.isHidden = true
                
            }
        case .failure(let error):
            print (error)
            self.handleError(error: error)
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.searchBarView.endEditing(true)
        let selectedAccount = self.accountList[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountDetailVC") as! AccountDetailViewController
        
        vc.account = selectedAccount
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView,trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        
        let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let account=self.accountList[indexPath.row]
            self.confirmRemoveAccount(account: account)
            success(true)
        })
        deleteAction.backgroundColor = UIColor.red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//****** MARK: UISearchBarDelegate

extension AccountListViewController:UISearchBarDelegate{
    
    // dismiss keyboard when user click on search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchBarView.endEditing(true)
    }
}

