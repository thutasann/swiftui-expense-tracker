//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by Thuta sann on 12/4/22.
//

import SwiftUI

struct TransactionList: View {
    
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        VStack{
            List{
                // MARK: Transaction Group
                ForEach(Array(transactionListVM.groupTransactionsByMonth()), id: \.key) { month, transactions in
                    Section{
                        // MARK: Transactin List
                        ForEach (transactions) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    } header: {
                        // MARK: Each Transaction Month
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews: PreviewProvider {
    
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel();
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM;
    }()
    
    static var previews: some View {
        NavigationView{
            TransactionList()
        }
        .environmentObject(transactionListVM)
        
    }
}
