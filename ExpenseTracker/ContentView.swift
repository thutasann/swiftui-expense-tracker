//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Thuta sann on 12/2/22.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    // var demoData: [Double] = [ 8, 2, 4, 6, 12, 9, 2 ]
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack (alignment: .leading, spacing: 24){
                    // MARK: Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    // MARK: Chart
                    let data = transactionListVM.accumulateTransactins()
                    if !data.isEmpty{
                        let totalExpenses = data.last?.1 ?? 0;
                        CardView {
                            VStack (alignment: .leading){
                                ChartLabel(totalExpenses.formatted(.currency(code: "USD")), type: .title, format: "$%.02f")
                                LineChart()
                            }
                            .background(Color.systemBackground) // For Dark Theme
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                        .frame(height: 300)
                    }
                    
                    
                    // MARK: Transaction List
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: Notification Item
                ToolbarItem{
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon, .primary)
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary) // For dark mode
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel();
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM;
    }()
    
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(transactionListVM)
            ContentView()
                .environmentObject(transactionListVM)
                .preferredColorScheme(.dark)
        }
    }
}
