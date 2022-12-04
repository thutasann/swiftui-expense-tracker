//
//  TransactionModel.swift
//  ExpenseTracker
//
//  Created by Thuta sann on 12/2/22.
//

import Foundation

struct Transaction: Identifiable, Decodable, Hashable{
    
    let id: Int
    let date: String
    let institution: String
    let account: String
    var merchant: String
    var amount: Double
    let type : TransactionType.RawValue
    var categoryId: Int
    var category: String
    let isPending: Bool
    var isTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool
    
    var dateParsed: Date{
        date.dateParsed()
    }
    
    // Signed Amount
    var signedAmount: Double{
        return type == TransactionType.credit.rawValue ? amount : -amount
    }
    
}

enum TransactionType : String{
    case debit = "debit"
    case credit = "credit"
}
