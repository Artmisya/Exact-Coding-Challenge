//
//  AccountDetailViewController.swift
//  Contact
//
//  Created by Saeedeh on 01/07/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import UIKit
import SDWebImage
class AccountDetailViewController: BaseViewController {

    @IBOutlet var accountTableView: UITableView!
    @IBOutlet var alertLabel: UILabel!
    @IBOutlet var alertView: UIView!
    @IBOutlet var deleteBtn: UIButton!
    @IBOutlet var saveBtn: UIButton!
    
    
    let placeHolderImage=UIImage(named: "unknown_user")
    let checkImage=UIImage(named: "tick")
    let unCheckImage=UIImage(named: "box")
    
    var account:Account?

    var keys=[String]()
    var values=[[Value]]()
    var imageCell:EditableImageCell?
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureTableView()
        loadAccountDetails()
    }
    func loadAccountDetails(){
        
        // first add userinput values if needed
        account?.addUserInputValues()
        
        initializeKeysValues()
        accountTableView.reloadData()
        self.view.isUserInteractionEnabled=true
        
    }
    private func initializeKeysValues(){
        
        keys.removeAll()
        values.removeAll()
        
        keys=account!.getKeys()
        for key in keys {
            
            let values=account!.getValues(forKey: key)
            self.values.append(values)
        }
        
    }
  private func configureUI(){
    
        saveBtn.backgroundColor=UIColor(red: 85.0/255.0, green: 107.0/255.0, blue: 47.0/255.0, alpha: 1.0)
        deleteBtn.backgroundColor=UIColor.red
    
        // setting up the back
        let btnName_back = UIButton()
        btnName_back .setImage(UIImage(named: "btn_back.png"), for: UIControlState())
        btnName_back .frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnName_back .addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        //.... Set Left Bar Button item
        let leftBarButton_back  = UIBarButtonItem()
        leftBarButton_back .customView = btnName_back
        
        self.navigationItem.leftBarButtonItem=leftBarButton_back
    }
    
    private func configureTableView() {
        
        self.accountTableView.delegate = self
        self.accountTableView.dataSource = self
        
        let nib = UINib(nibName: "LabelCell", bundle: nil)
        accountTableView.register(nib, forCellReuseIdentifier: "LabelCell")
        
        let ImageBaseCellnib = UINib(nibName: "ImageCell", bundle: nil)
        accountTableView.register(ImageBaseCellnib, forCellReuseIdentifier: "ImageCell")
        
        let EditableLabelCellnib = UINib(nibName: "EditableLabelCell", bundle: nil)
        accountTableView.register(EditableLabelCellnib, forCellReuseIdentifier: "EditableLabelCell")
        
        let EditableImageCellnib = UINib(nibName: "EditableImageCell", bundle: nil)
        accountTableView.register(EditableImageCellnib, forCellReuseIdentifier: "EditableImageCell")
        
        self.accountTableView.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        
        accountTableView.rowHeight = UITableViewAutomaticDimension
        accountTableView.estimatedRowHeight = 200.0
    }
    
    private func removeAccount(){
        
        let dataRecord=DataRecord.sharedInstance
        let result=dataRecord.removeAccount(account:account!)
        
        switch result {
        case .success(_):
            
            alertLabel.text=Constants.DataRecord.Message.deleteAccountSuccess
            alertView.isHidden = false
            
            let when = DispatchTime.now() + 1.0
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.alertView.isHidden = true
                self.navigationController?.popViewController(animated: true)
            }
        case .failure(let error):
            print (error)
            self.handleError(error: error)
        }
    }

    @IBAction func deleteBtnClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "", message: Constants.DataRecord.Message.deleteAccountAlert, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.removeAccount()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
            return
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        
       let result=account!.save()
      
        switch result {
        case .success(_):
            
            alertLabel.text=Constants.Account.Message.saveAccountSuccess
            alertView.isHidden = false
            // reset values 
            initializeKeysValues()
            // refresh tableView
            accountTableView.reloadData()
            
            let when = DispatchTime.now() + 1.0
            DispatchQueue.main.asyncAfter(deadline: when) {
                
                self.alertView.isHidden = true
                
            }
        case .failure(let error):
            print (error)
            self.handleError(error: error)
        }
    }
}

//****** MARK: tableview delegates

extension AccountDetailViewController:UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let key=keys[section]
        //indicate compulsory fields with '*'
        if (account!.isKeyCompulsory(key:key)){
            
            return "\(self.keys [section])*"
        }
        return self.keys [section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return self.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.values[section].count
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        
        let key=keys[section]
        let header = view as! UITableViewHeaderFooterView
        
         //indicate compulsory fields with red color
        if (account!.isKeyCompulsory(key:key)){
            
            header.textLabel?.textColor = Constants.Account.ColorIndicator.compulsoryKey
        }
        else{
            
            header.textLabel?.textColor = UIColor.black
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let listOfvalues:[Value]=self.values[indexPath.section]
        let value:Value=listOfvalues[indexPath.row]

        //1. Case Editabl Cell: this key does not have any actual value, return an editable cell for this key
        if value.isUserInput {
            
            //1.1 if it is an image base values.
            if keys[indexPath.section]==Constants.Account.Keys.ImageType{
                
                let cell:EditableImageCell = tableView.dequeueReusableCell(withIdentifier: "EditableImageCell") as! EditableImageCell
                cell.delegate=self
                cell.selectionStyle = .none
                
                //  if user has added any image load that image
                if let imageData=value.imageData {
                    
                    cell.valueImage.image=UIImage(data:imageData,scale:1.0)
                }
                else{
                       cell.valueImage.image=placeHolderImage
                }
                return cell
            }
            else{
                 // 1.2 if it is an label base values....

                let cell:EditableLabelCell = tableView.dequeueReusableCell(withIdentifier: "EditableLabelCell") as! EditableLabelCell
                cell.delegate=self
                cell.selectionStyle = .none
                
                cell.inputLabel.text = value.data.replacingOccurrences(of: "\\n",with:"\n")
                return cell
            }
        }
        
        // 2. Case of none editable Cell:
        //2.1 if it is an image base values....
        if keys[indexPath.section]==Constants.Account.Keys.ImageType{

            let cell:ImageCell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
            cell.selectionStyle = .none
            
            if let url = URL(string: value.data){
                   cell.valueImage.sd_setImage(with: url,placeholderImage:placeHolderImage, options: SDWebImageOptions(rawValue: 0),completed: nil)
            }
            if(value.selected==true){
                
                cell.selectImageView.image=checkImage
            }
            else{
                cell.selectImageView.image=unCheckImage
            }
            
            // in case the account doesnot have any mismatch data hide the check box
            if(account?.isMismatched()==false){
                cell.isUserInteractionEnabled = false
                cell.selectImageView.isHidden = true
            }
            else
            {
                //  in case the account has mismatch data let user to select the correct data
                cell.isUserInteractionEnabled=true
                cell.selectImageView.isHidden = false
            }
            
            return cell
        }
        else{
            //2.2 if it is an label base values....
            let cell:LabelCell = tableView.dequeueReusableCell(withIdentifier: "LabelCell") as! LabelCell
            cell.selectionStyle = .none
            
            cell.valueTextView.text = value.data.replacingOccurrences(of: "\\n",with:"\n")
            if(value.selected==true){

                cell.selectImageView.image=checkImage
            }
            else{
                cell.selectImageView.image=unCheckImage
            }
            // in case the account doesnot have any mismatch data hide the checkbox
            if(account?.isMismatched()==false){
                cell.isUserInteractionEnabled = false
                cell.selectImageView.isHidden = true
            }
            else
            {
                //  in case the account has mismatch data let user to select the correct data
                cell.isUserInteractionEnabled=true
                cell.selectImageView.isHidden = false
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (tableView.cellForRow(at:indexPath) is EditableLabelCell || tableView.cellForRow(at:indexPath) is EditableLabelCell) {
             return
        }
        
        let listOfvalues:[Value]=self.values[indexPath.section]
        let value:Value=listOfvalues[indexPath.row]

        if let cell=tableView.cellForRow(at:indexPath) as? LabelCell{
            
            if(value.selected==true){
                
                value.selected = false
                cell.selectImageView.image=unCheckImage
            }
            else{
                
                value.selected = true
                cell.selectImageView.image=checkImage
            }
            return
        }
        if let cell=tableView.cellForRow(at:indexPath) as? ImageCell{
            
          if(value.selected==true){
                value.selected = false
                cell.selectImageView.image=unCheckImage
            }
            else{
                value.selected = true
                cell.selectImageView.image=checkImage
            }

            return
        }
    }
}

//****** MARK: EditableLabelCellDelegate delegates
extension AccountDetailViewController:EditableLabelCellDelegate{
    
    func textFieldDidEndEditing(cell: EditableLabelCell, userInput: String) -> () {
        
        if let indexPath = accountTableView.indexPathForRow(at: cell.convert(cell.bounds.origin, to: accountTableView)){
            
            let listOfvalues:[Value]=self.values[indexPath.section]
            let valueObject:Value=listOfvalues[indexPath.row]
            
            // update the data with user input
            valueObject.data=userInput
          
        }
    }
}
//****** MARK: ImagePickerDelegate delegates
extension AccountDetailViewController:ImagePickerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func pickImage(cell:EditableImageCell){
        
        imageCell=cell
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        
        let alertController = UIAlertController(title: "Select Picture", message: "", preferredStyle: .alert)

        let cameraRollAction = UIAlertAction(title: "Gallery", style: .default) { (action) in
            imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(cameraRollAction)
        
        let takePictureAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            self.present(imagePicker,animated: true,completion: nil)
        }
        alertController.addAction(takePictureAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.imageCell?.valueImage.image = image
            if let imageData=UIImageJPEGRepresentation(image, 0.0)! as NSData? {
                
                if let indexPath = accountTableView.indexPathForRow(at: (imageCell?.convert((imageCell?.bounds.origin)!, to: accountTableView))!){
                    let listOfvalues:[Value]=self.values[indexPath.section]
                    let valueObject:Value=listOfvalues[indexPath.row]
                    
                    // update the data with user input
                    valueObject.imageData=imageData as Data
                }
            }
        }
    }
}
