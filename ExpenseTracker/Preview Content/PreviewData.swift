//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Thuta sann on 12/2/22.
//

import Foundation
import SwiftUI

var transactionPreviewData = Transaction(id: 1, date: "01/24/2022", institution: "Desjardins", account: "Thuta Sann", merchant: "Apple", amount: 11.56, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: true, isExpense: true, isEdited: true)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
