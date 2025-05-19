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


// MARK: - Formatting

/// A structure that converts between code coverage reports and their textual representations.
///
/// Strings output by the format style look like: "*lineCoverage* (*coveredLines* of *executableLines*)". For example,
/// if line coverage is 0.8335, covered lines is 85023, and executable lines is 102004, the output string would be
/// "83.35% (85,023 of 102,004)".
struct CodeCoverageReportFormatStyle: FormatStyle {
    func format(_ report: any CodeCoverageReport) -> String {
        let lineCoverage = report.lineCoverage.formatted(.percent.precision(.fractionLength(2)))
        let coveredLines = report.coveredLines.formatted(.number)
        let executableLines = report.executableLines.formatted(.number)

        return "\(lineCoverage) (\(coveredLines) of \(executableLines))"
    }
}


extension CodeCoverageReport {
    /// Returns a formatted version of the report using `CodeCoverageReportFormatStyle`.
    func formatted() -> String {
        return CodeCoverageReportFormatStyle().format(self)
    }
}
