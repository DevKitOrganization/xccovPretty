//
//  CodeCoverageFileNode.swift
//  xccovPretty
//
//  Created by Prachi Gauriar on 5/21/25.
//

import Foundation


/// `CodeCoverageFileNode`s are used to describe the hierarchy of files within a target.
final class CodeCoverageFileNode {
    /// The name of the file.
    let name: String

    /// The code coverage report corresponding to the file. If `nil`, this node represents a directory that has no
    /// coverage data.
    var codeCoverageReport: (any CodeCoverageReport)?

    /// The node’s children. The keys in the dictionary are the children’s names, and the values are their nodes.
    var children: [String : CodeCoverageFileNode] = [:]


    /// Creates a new `CodeCoverageFileNode` with the specified name.
    ///
    /// - Parameter name: The name of the new node.
    init(name: String) {
        self.name = name
    }


    /// Returns whether the node represents a directory.
    var isDirectory: Bool {
        return codeCoverageReport == nil
    }


    /// Adds a child containing information from the file code coverage report.
    ///
    /// - Parameter fileReport: The file code coverage report for which to add a child.
    func addChild(for fileReport: FileCodeCoverageReport) {
        let components = fileReport.path.split(separator: "/", omittingEmptySubsequences: false).map { String($0) }

        // Find or create all the nodes for the file report’s path.
        var currentNode = self
        for component in components {
            if let node = currentNode.children[component] {
                // If a node already exists, use it
                currentNode = node
            } else {
                // Otherwise, create a new node, add it to the current node’s children, and set this node as the current
                // node.
                let newNode = CodeCoverageFileNode(name: component)
                currentNode.children[component] = newNode
                currentNode = newNode
            }
        }

        // Once we get through all the components, currentNode represents the node for our file. Set its fileReport.
        currentNode.codeCoverageReport = fileReport
    }
}
