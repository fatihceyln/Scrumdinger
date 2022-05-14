//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by Fatih Kilit on 8.05.2022.
//

import Foundation
import SwiftUI

class ScrumStore: ObservableObject {
    // we didn't assign any value to @Published scrums. We will assign to it in App file
    // we can assign a new value to @Published variable inside a View or App that observe this variable
    @Published var scrums: [DailyScrum] = []
    
    private static func fileURL() throws -> URL {
        // getting and returning file url
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("scrums.data")
    }
    
    static func load(completion: @escaping (Result<[DailyScrum] ,Error>) -> ()) {
        DispatchQueue.global(qos: .background).async {
            do {
                // getting file url
                let fileURL = try fileURL()
                // trying to read saved file via 'FileHandle'
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                // decoding data that have been read, and assign them to new array
                let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: file.availableData)
                
                // When you use @escaping closure you have to send data via DispatchQueue.main.async because you're updating UI
                DispatchQueue.main.async {
                    completion(.success(dailyScrums))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }

    static func save(scrums: [DailyScrum], completion: @escaping(Result<Int, Error>) -> ()) {
        DispatchQueue.global(qos: .background).async {
            do {
                // encoding [DailyScrum]
                let data = try JSONEncoder().encode(scrums)
                // getting file url
                let url = try fileURL()
                // writing data to given url
                try data.write(to: url)
                
                // when you use @escaping closure you have to send data via DispatchQueu.main.async because you're updating UI
                DispatchQueue.main.async {
                    completion(.success(scrums.count))
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
