//
//  ConcurrencyTests.swift
//  DocumentationTests
//
//  Created by feed0 on 2026/06/08.
//

import Testing
import Foundation

struct ConcurrencyTests {
    
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Defining-and-Calling-Asynchronous-Functions
    @Test("Sequential async execution")
    func downloadPhotoFlow() async {
        /// Arrange
        print("\t▶️ Start: Preparing to download photo...")
        
        let name = "Summer_Vacation_01"
        
        /// Act
        let photo = await downloadPhoto(named: name)
        
        /// Assert
        #expect(!photo.data.isEmpty)
        print("\t📦 Downloaded \(photo.byteCount) bytes for \(name).")
        print("\t⏹️ End: Photo processing complete.")
    }
    
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Asynchronous-Sequences
    @Test("Async array stream")
    func donwloadMultiplePhotos() async {
        /// Arrange
        print("\t▶️ Start: Preparing to download multiple photos...")
        
        let photoNames = ["Sunset", "Mountain", "City_Lights", "Whale", "Dawn", "Dusk", "Tides", "Waves", "Model", "Editorial"]
        
        let photosAsyncStream = AsyncStream<PhotoModel> { continuation in
            Task {
                for photoName in photoNames {
                    let photo = await downloadPhoto(named: photoName)
                    continuation.yield(photo)
                }
                continuation.finish()
            }
        }
        
        /// Act
        for await photo in photosAsyncStream {
            print("\t📦 Downloaded \(photo.data.count) bytes for {\(photo.name)}.")
        }
        
        /// Assert
        print("\t⏹️ End: Multiple photos processing complete.")
    }
}
