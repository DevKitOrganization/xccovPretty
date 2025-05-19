//
//  ProjectCodeCoverageReport.swift
//  xccovPretty
//
//  Created by Prachi Gauriar on 5/19/25.
//
//

import Foundation


/// Code coverage statistics for an entire project.
struct ProjectCodeCoverageReport: CodeCoverageReport {
    let coveredLines: Int
    let executableLines: Int
    let lineCoverage: Double

    /// Code coverage statistics for each target in the project.
    let targets: [TargetCodeCoverageReport]
}
