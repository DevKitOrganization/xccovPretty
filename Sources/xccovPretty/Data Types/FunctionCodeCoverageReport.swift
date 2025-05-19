//
//  FunctionCodeCoverageReport.swift
//  xccovPretty
//
//  Created by Prachi Gauriar on 5/19/25.
//

import Foundation


/// Code coverage statistics for a function within a file.
struct FunctionCodeCoverageReport: CodeCoverageReport {
    let coveredLines: Int
    let executableLines: Int
    let lineCoverage: Double

    /// The name of the function.
    let name: String

    /// The line number on which the body of the function starts.
    let lineNumber: Int

    /// The number of times the function was executed.
    let executionCount: Int
}
