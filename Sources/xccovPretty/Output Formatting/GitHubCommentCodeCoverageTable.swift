//
//  GitHubCodeCoverageComment.swift
//  xccovPretty
//
//  Created by Prachi Gauriar on 5/19/25.
//

import Foundation


/// `GitHubCodeCoverageComment` generates a GitHub Comment containing code coverage information.
struct GitHubCodeCoverageComment: CustomStringConvertible {
    private struct TargetDetails {
        /// The target’s code coverage report.
        let targetReport: TargetCodeCoverageReport

        /// The target’s rows.
        let rows: [Row]


        var html: String {
            let tableRows = rows
                .sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
                .map { $0.html }
                .joined(separator: "\n")

            return """
            <details>
            <summary><strong>\(targetReport.name)</strong>: \(targetReport.formatted())</summary>
            <table>
                <thead>
                    <tr>
                        <th>File</th>
                        <th>Coverage</th>
                        <th>Covered Lines</th>
                        <th>Executable Lines</th>
                    </tr>
                </thead>
                <tbody>
            \(tableRows)
                </tbody>
            </table>
            </details>
            """
        }
    }


    /// The `Row` type represents a row in the HTML code coverage table.
    private struct Row {
        /// The name to display for the row.
        let name: String

        /// The code coverage report for this row.
        let codeCoverageReport: any CodeCoverageReport


        /// Returns an HTML table row representation.
        var html: String {
            let coverage = codeCoverageReport.lineCoverage
                .formatted(.percent.precision(.fractionLength(2)))
            let coveredLines = codeCoverageReport.coveredLines.formatted(.number)
            let executableLines = codeCoverageReport.executableLines.formatted(.number)

            return """
                <tr>
                    <td>\(name)</td>
                    <td>\(coverage)</td>
                    <td>\(coveredLines)</td>
                    <td>\(executableLines)</td>
                </tr>
            """
        }
    }


    /// The project coverage report.
    private let projectReport: ProjectCodeCoverageReport

    /// The comment’s target details.
    private let targetDetails: [TargetDetails]


    /// Creates a new `HTMLCodeCoverageTable` for the specified project code coverage report.
    ///
    /// - Parameters:
    ///   - projectReport: The project code coverage report that the `HTMLCodeCoverageTable` summarizes.
    ///   - includedTargetNames: The target names to include in the report. If `nil`, all targets are included.
    init(projectReport: ProjectCodeCoverageReport, includedTargetNames: [String]? = nil) {
        self.projectReport = projectReport
        self.targetDetails = Self.targetDetails(for: projectReport, includedTargetNames: includedTargetNames)
    }


    var description: String {
        return """
        ## Code Coverage Report
        
        **Overall Coverage**: \(projectReport.formatted())
        
        \(targetDetails.map(\.html).joined(separator: "\n"))        
        """
    }


    /// Returns target details for each target in the specified project code coverage report.
    private static func targetDetails(
        for projectReport: ProjectCodeCoverageReport,
        includedTargetNames: [String]?
    ) -> [TargetDetails] {
        return projectReport.targets.compactMap { (targetReport) in
            guard includedTargetNames?.contains(targetReport.name) ?? true,
                  !targetReport.files.isEmpty
            else {
                return nil
            }

            return TargetDetails(
                targetReport: targetReport,
                rows: targetReport.files.map { fileReport in
                    let filename = (fileReport.path as NSString).lastPathComponent
                    return Row(name: filename, codeCoverageReport: fileReport)
                }
            )
        }
    }
}
