//
//  TransactionModel.swift
//  ExpenseTracker
//
//  Created by Thuta sann on 12/2/22.
//

import Foundation
import SwiftUIFontIcon
import UIKit


// Transaction
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
    
    // Icon
    var icon: FontAwesomeCode{
        if let category = Category.all.first(where: { $0.id == categoryId }) {
            return category.icon
        }
        
        return .question
    }
    
    // Date parsed
    var dateParsed: Date{
        date.dateParsed()
    }
    
    // Signed Amount
    var signedAmount: Double{
        return type == TransactionType.credit.rawValue ? amount : -amount
    }
    
}

// Transaction Type
enum TransactionType : String{
    case debit = "debit"
    case credit = "credit"
}

// Category
struct Category{
    let id: Int
    let name: String
    let icon: FontAwesomeCode
    var mainCategoryID : Int?
}


// Category Extension
extension Category{
    static let autoAndTransport = Category(id: 1, name : "Auto & Transport", icon: .car_alt)
    static let billsAndUtilities = Category(id: 2, name: "Bills & Utilities", icon: .file_invoice_dollar)
    static let entertainment = Category(id: 3, name: "Entertainment", icon: .film)
    static let feesAndCharges = Category(id: 4, name: "Fees & Charges", icon: .hand_holding_usd)
    static let foodAndDining = Category(id: 5, name: "Food & Dining", icon: .hamburger)
    static let home = Category(id: 6, name: "Home", icon: .home)
    static let income = Category(id: 7, name: "Income", icon: .dollar_sign)
    static let shopping = Category(id: 8, name: "Shopping", icon: .shopping_cart)
    static let transfer = Category(id: 9, name: "Transfer", icon: .exchange_alt)
    
    static let publicTransportation = Category(id: 101, name: "Public Transportation", icon: .bus, mainCategoryID: 1)
    static let taxi = Category(id: 102, name: "Bills & Utilities", icon: .taxi, mainCategoryID: 1)
    static let mobilePhone = Category(id: 201, name: "Mobile Phone", icon: .mobile_alt)
    static let moviesAndDVDs = Category(id: 301, name: "Movies And DVDS", icon: .film, mainCategoryID: 3)
    static let bankFee = Category(id: 401, name: "Bank Fee", icon: .hand_holding_usd, mainCategoryID: 4)
    static let financeCharge = Category(id: 402, name: "Finance Charge", icon: .hand_holding_usd, mainCategoryID: 4)
    static let groceries = Category(id: 501, name: "Groceries", icon: .shopping_basket, mainCategoryID: 5)
    static let restaurants = Category(id: 502, name: "Restaurants", icon: .utensils, mainCategoryID: 5)
    static let rent = Category(id: 601, name: "Rent", icon: .house_user, mainCategoryID: 6)
    static let homeSupplies = Category(id: 602, name: "Home Supplies", icon: .lightbulb, mainCategoryID: 6)
    static let paycheque = Category(id: 701, name: "Paycheque", icon: .dollar_sign, mainCategoryID: 7)
    static let software = Category(id: 801, name: "Software", icon: .icons, mainCategoryID: 8)
    static let creditCardPayment = Category(id: 901, name: "Credit Card Payment", icon: .exchange_alt, mainCategoryID: 9)
}


extension Category{
    static let categories: [Category] = [
        .autoAndTransport,
        .billsAndUtilities,
        .entertainment,
        .feesAndCharges,
        .foodAndDining,
        .home,
        .income,
        .shopping,
        .transfer
    ];
    
    static let subCategories: [Category] = [
        .publicTransportation,
        .taxi,
        .mobilePhone,
        .moviesAndDVDs,
        .bankFee,
        .financeCharge,
        .groceries,
        .restaurants,
        .rent,
        .homeSupplies,
        .paycheque,
        .software,
        .creditCardPayment
    ];
    
    static let all: [Category] = categories + subCategories
}
