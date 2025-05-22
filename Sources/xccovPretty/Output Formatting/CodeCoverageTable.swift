//
//  CodeCoverageTable.swift
//  xccovPretty
//
//  Created by Prachi Gauriar on 5/19/25.
//

import Foundation


/// `CodeCoverageTable`s can take a `ProjectCodeCoverageReport` and produce a human-readable textual representation.
struct CodeCoverageTable: CustomStringConvertible {
    /// The `Row` type represents a row in the code coverage table.
    private struct Row {
        /// The name to display for the row.
        let name: String

        /// The coverage summary information to show for the row.
        let coverageSummary: String

        /// The row’s indentation level.
        let indentationLevel: Int


        /// A textual representation of the string given the specified name column width.
        ///
        /// - Parameter nameColumnWidth: The total number of characters that should be used for the row’s name.
        /// - Returns: A textual representation of the row.
        func description(nameColumnWidth: Int) -> String {
            let indentationString = String(repeating: " ", count: indentationWidth)
            let paddingString = String(repeating: " ", count: nameColumnWidth - name.count - indentationWidth)
            return "\(indentationString)\(name)\(paddingString)    \(coverageSummary)"
        }


        /// The number of spaces used to indent the row.
        var indentationWidth: Int {
            return indentationLevel * 4
        }
    }

    /// The table’s rows.
    private let rows: [Row]

    /// Creates a new `CodeCoverageTable` for the specified project code coverage report.
    ///
    /// - Parameters:
    ///   - projectReport: The project code coverage report that the `CodeCoverageTable` summarizes.
    ///   - includedTargetNames: The target names to include in the report. If `nil`, all targets are included.
    init(projectReport: ProjectCodeCoverageReport, includedTargetNames: [String]? = nil) {
        self.rows = Self.rows(for: projectReport, includedTargetNames: includedTargetNames)
    }


    var description: String {
        let nameColumnWidth = rows.reduce(0) { (maxWidth, row) in
            return max(maxWidth, row.name.count + row.indentationWidth)
        }

        return rows.reduce(into: "") { (string, row) in
            string.append(row.description(nameColumnWidth: nameColumnWidth))
            string.append("\n")
        }
    }


    // MARK: - Creating Rows

    /// Returns rows that represent the data in the specified project code coverage report.
    ///
    /// - Parameters:
    ///   - projectReport: The project code coverage report for which to return rows.
    ///   - includedTargetNames: The target names to include in the report. If `nil`, all targets are included.
    /// - Returns: The rows containing the project’s code coverage information.
    private static func rows(
        for projectReport: ProjectCodeCoverageReport,
        includedTargetNames: [String]?
    ) -> [Row] {
        return projectReport.targets.flatMap { (targetReport) -> [Row] in
            guard includedTargetNames?.contains(targetReport.name) ?? true else {
                return []
            }

            return rows(for: targetReport)
        }
    }


    /// Returns rows that represent the data in the specified target code coverage report.
    ///
    /// - Parameter targetReport: The target code coverage report for which to return rows.
    /// - Returns: The rows containing the target’s code coverage information.
    private static func rows(for targetReport: TargetCodeCoverageReport) -> [Row] {
        // If the target has no files, skip it. This works around an issue in test reports on SwiftPM packages where
        // you get a duplicate empty
        guard !targetReport.files.isEmpty else {
            return []
        }

        // Create a target tree node for the
        let targetTreeNode = CodeCoverageFileNode(name: targetReport.name)
        targetTreeNode.codeCoverageReport = targetReport

        for fileReport in targetReport.files {
            targetTreeNode.addChild(for: fileReport)
        }

        return rows(for: targetTreeNode)
    }


    /// Recursive function that returns the rows for the specified code coverage file node.
    ///
    /// - Parameters:
    ///   - node: The tree node for which to return rows.
    ///   - namePrefix: The string with which to prefix the name of the top-level node. This is used to coalesce
    ///     multiple empty directories into a single node.
    ///   - indentationLevel: The indentation level for the top-level node.
    /// - Returns: The rows containing the node’s code coverage information.
    private static func rows(
        for node: CodeCoverageFileNode,
        namePrefix: String = "",
        indentationLevel: Int = 0
    ) -> [Row] {
        // Generate the name to use for the top-level node
        let name = "\(namePrefix)\(node.name)\(node.isDirectory ? "/" : "")"

        // If the node is a directory with only one element in it, coalesce it into a single item.
        if node.isDirectory && node.children.count == 1 {
            return rows(for: node.children.first!.value, namePrefix: name, indentationLevel: indentationLevel)
        }

        // Create a top-level row
        var fileRows = [
            Row(
                name: name,
                coverageSummary: node.codeCoverageReport?.formatted() ?? "",
                indentationLevel: indentationLevel
            )
        ]

        // Sort the child nodes in ascending order by name
        let sortedChildNodes = node.children
            .sorted { $0.key.localizedCompare($1.key) == .orderedAscending }
            .map { $0.value }

        // Generate rows for each of the children and append them to our list of rows
        fileRows.append(contentsOf: sortedChildNodes.flatMap { rows(for: $0, indentationLevel: indentationLevel + 1) })
        return fileRows
    }
}
