//
//  ErrorView.swift
//  Scrumdinger
//
//  Created by Fatih Kilit on 14.05.2022.
//

import SwiftUI

struct ErrorView: View {
    
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("An error has occured!")
                    .font(.title)
                    .padding(.bottom)
                
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    
    enum SampleError: Error {
        case errorRequired
    }
    
    // this computed property has to be 'static'. If you don't do that You can't use it as parameter in previews.
    static var wrapper: ErrorWrapper {
        ErrorWrapper(error: SampleError.errorRequired, guidance: "You can safely ignore this error.")
    }
    
    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }
}
