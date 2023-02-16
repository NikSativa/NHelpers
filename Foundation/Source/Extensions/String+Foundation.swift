import Foundation

public extension String {
    func indicesOf(_ string: String) -> [Int] {
        var indices = [Int]()
        var searchStartIndex = startIndex

        while searchStartIndex < endIndex,
              let range = range(of: string, range: searchStartIndex..<endIndex),
              !range.isEmpty {
            let index = distance(from: startIndex, to: range.lowerBound)
            indices.append(index)
            searchStartIndex = range.upperBound
        }

        return indices
    }
}
