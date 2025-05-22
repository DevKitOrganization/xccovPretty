//
//  CodeCoverageReport.swift
//  xccovPretty
//
//  Created by Prachi Gauriar on 5/19/25.
//

import Foundation


/// A type with code coverage statistics.
protocol CodeCoverageReport: Codable, Hashable, Sendable {
    /// The number of lines covered by tests.
    var coveredLines: Int { get }

    /// The total number of executable lines.
    var executableLines: Int { get }

    /// The proportion of lines covered to executable lines.
    ///
    /// 0.0 means no lines; 1.0 means 100% of lines.
    var lineCoverage: Float64 { get }
}
