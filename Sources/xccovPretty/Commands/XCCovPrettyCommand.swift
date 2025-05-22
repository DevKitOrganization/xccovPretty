//
//  XCCovPrettyCommand.swift
//  xccovPretty
//
//  Created by Prachi Gauriar on 5/19/25.
//

import ArgumentParser
import Foundation


/// A command that outputs an xccov report more prettily.
@main
struct XCCovPrettyCommand : AsyncParsableCommand {
    static var configuration: CommandConfiguration {
        return .init(
            commandName: "xccovPretty",
            abstract: "A tool for outputting an xccov report more prettily."
        )
    }

    @Flag(name: .customLong("github-comment"), help: "Output for GitHub PR comments")
    var gitHubComment = false

    mutating func run() throws {
        let projectReport = try projectReport(from: .standardInput)
        
        if gitHubComment {
            let comment = GitHubCodeCoverageComment(projectReport: projectReport)
            print(comment)
        } else {
            let table = CodeCoverageTable(projectReport: projectReport)
            print(table)
            print("Overall coverage: \(projectReport.formatted()).")
        }
    }


    func projectReport(from fileHandle: FileHandle) throws -> ProjectCodeCoverageReport {
        guard let inputData = try FileHandle.standardInput.readToEnd() else {
            throw ReadError("Could not read data from stdin.")
        }

        do {
            return try JSONDecoder().decode(ProjectCodeCoverageReport.self, from: inputData)
        } catch {
            throw ReadError("Failed to parse JSON from stdin. \(error)")
        }
    }
}


private struct ReadError: Error, CustomStringConvertible {
    var description: String


    init(_ description: String) {
        self.description = description
    }
}
