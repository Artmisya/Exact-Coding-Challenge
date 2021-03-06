//
//  StringExtensions.swift
//  Contact
//
//  Created by Saeedeh on 03/07/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {

        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil

    }
}
