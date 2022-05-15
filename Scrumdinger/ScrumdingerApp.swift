//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Fatih Kilit on 1.05.2022.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $store.scrums) {
                    /*
                    ScrumStore.save(scrums: store.scrums) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                    */
                    Task // Task provides an asynchronous context from which you can call fetchRandomNumber.
                    {
                        do {
                            try await ScrumStore.save(scrums: store.scrums)
                        } catch let error {
                            errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                        }
                    }
                }
            }
            /*
            .onAppear {
                ScrumStore.load { completion in
                    switch completion {
                    case .success(let scrums):
                        store.scrums = scrums
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    }
                }
            }
            */
            .task // task is a modifier that calls an async function when the system creates a view.
            {
                do {
                    // scrums is assigned a new value when the awaited function completes. Because scrums is a published property, any view observing ScrumStore refreshes when the property updates.
                    store.scrums = try await ScrumStore.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Scrumdinger will laod sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper) {
                store.scrums = DailyScrum.sampleData
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }

        }
        
        /*
        WindowGroup {
            TestView()
        }
        */
    }
}
