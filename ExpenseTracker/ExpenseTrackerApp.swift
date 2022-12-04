//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Thuta sann on 12/2/22.
//

// @StateObject -> Follows the lifecycle of the App

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    
    @StateObject var transactionListVM = TransactionListViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
