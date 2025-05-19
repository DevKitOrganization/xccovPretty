//
//  TargetCodeCoverageReport.swift
//  xccovPretty
//
//  Created by Prachi Gauriar on 5/19/25.
//

import Foundation


/// Code coverage statistics for a target within a project.
struct TargetCodeCoverageReport: CodeCoverageReport {
    let coveredLines: Int
    let executableLines: Int
    let lineCoverage: Double

    /// The name of the target.
    let name: String

    /// The path to the build product for the target.
    let buildProductPath: String

    /// Code coverage statistics for each file in the target.
    let files: [FileCodeCoverageReport]
}
