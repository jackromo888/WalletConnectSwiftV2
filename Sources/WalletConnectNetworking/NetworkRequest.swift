import Foundation

public protocol NetworkRequest {
    var method: String { get }
    var tag: String { get }
}
