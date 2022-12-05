//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by Thuta sann on 12/3/22.
// @Published -> send notifications to the subscribers whenever its value is changed

// typealias -> Type Aliases allow defining types with a custom name (an Alias).


import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]> // To order Transaction Group by Month
typealias TransactionPrefixSum = [(String, Double)] // String -> Date, Double -> Amount

final class TransactionListViewModel: ObservableObject {
    
    
    @Published var transactions: [Transaction] = [];
    
    // MARK: Cancellables
    private var cancellables = Set<AnyCancellable>();
    
    // MARK: - Get Transactions Ini
    init(){
        getTransactions()
    }
    
    // MARK: - Fetch Transacations from the Network
    func getTransactions(){
        
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        // Fetching from URL
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print("Error Fetching Transactions", error.localizedDescription)
                case .finished:
                    print("Finish Fetching Transctions")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
                dump(self?.transactions)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Group Transaction by month
    func groupTransactionsByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] } //[:] empty dictionary
        
        let groupedTransactions = TransactionGroup(grouping: transactions) { $0.month }
        
        return groupedTransactions
                         
    }
    
    
    // MARK: - Accumulate Transaction for Chart Data
    func accumulateTransactins() -> TransactionPrefixSum {
        print("accumulateTransactions")
        guard !transactions.isEmpty else { return [] }
        
        let today = "02/17/2022".dateParsed() // Date()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)! // ! <- Force
        print("dateInterval", dateInterval)
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        
        // MARK: Stride
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24){
            let dailyExpenses = transactions.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(), sum)) // String, Double
            print(date.formatted(), "dailyTotal:", dailyTotal, "sum:", sum)
        }
        
        return cumulativeSum;
    }
}
