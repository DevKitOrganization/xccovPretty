//
//  FileCodeCoverageReport.swift
//  xccovPretty
//
//  Created by Prachi Gauriar on 5/19/25.
//

import Foundation


/// Code coverage statistics for a file within a target.
struct FileCodeCoverageReport: CodeCoverageReport {
    let coveredLines: Int
    let executableLines: Int
    let lineCoverage: Double

    /// The name of the file.
    let name: String

    /// The full path to the file (including the name).
    let path: String

    /// Code coverage statistics for each function in the file.
    let functions: [FunctionCodeCoverageReport]
}
