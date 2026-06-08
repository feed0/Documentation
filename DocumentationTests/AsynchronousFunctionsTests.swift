//
//  AsynchronousFunctionsTests.swift
//  DocumentationTests
//
//  Created by feed0 on 2026/06/08.
//

import Testing
import Foundation

actor AsynchronousFunctionsTests {
    
    @Test("Test sequential async execution")
    func testDownloadPhotoFlow() async {
        print("\t▶️ Start: Preparing to download photo...")
        
        let name = "Summer_Vacation_01"
        let photoData = await downloadPhoto(named: name)
        
        #expect(!photoData.isEmpty)
        print("\t📦 Downloaded \(photoData.count) bytes for \(name).")
        print("\t⏹️ End: Photo processing complete.")
    }
}
