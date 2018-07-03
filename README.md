# Exact Codding Challenge
# Version 1.0

# Overview
The app includes two pages. the first page list down all accounts (showing their account id) with two colors indicator, **yellow** and **red**. Yellow color indicates an **mistmatch account** while red color indicates an **incomplete account**. If there are more than one value for account's keys then the account will be mark with yellow color. If an account is marke with red color that means one or more of compasury keys for that account are empty.
Please note that an account can be mark with both colors as one account might be both mistmatch and incomplete.

When user click on an account, she/he will be redirect into the Account Detail page where she can  select a correct value for a key (if that key has more than one value) or insert a new value for a key (if that key does not have any value). In this page user can Save/Delete an account. Please note that editable keys (those key that doesnot have any values) always remain editable for user, so even after save she can come back and edit those keys again. When user press save the app provides user with an error message  in case one or more compasury fields is/are left empty (Compasury fields are highlet with red color in UI).
#### Features:
- **Delete**
user can delete an account either in the first page by **swiping** a table cell to the **left**, or in the account detail page by pressing the delete button.
- **Instance Search:** 
The search function search a keyword among **all of account fields** (first name, last name, email, phone, note and etc) except pictute url.


- **Pull Down to Refresh:**
To reset data (fill data with api results) user can pull down the page


# Unit Tests
The application includes the following unit tests:
- testNetworkService
- testNetworkServiceWithUnreachableUrl
- testNetworkServiceWithNoInternetConnection (* internet connection must be **OFF** while perform this test) 
- testAccountIsArrayEmpty
- testAccountIsIncomplete
- testAccountMerge
- testAccountSave
- testAccountDecodeFromData
- testDataRecordDecodeContactsFromData
- testDataRecordMergeSimilarAccounts
- testDataRecordMergeSimilarAccounts
- testDataRecordFetchContactsWithNoInternet (*internet connection must be **OFF** while perform this test ) 
- testDataRecordRemoveAccount

# Architecture Pattern

 This app is developed based on MVC model.

# Language & Frameworks 
This app has been developeb by using the following frameworks and language
- Swift4 , 
- RxSwift,
- RxCocoa (RxSwift and RxCoCoa have been used in search function only)
-
# How to Run?
To run this application you will need xcode **9.3 or higher**.

