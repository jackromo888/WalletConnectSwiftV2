// 

import Foundation
@testable import WalletConnect_Swift

class MockedJSONRPCTransport: JSONRPCTransporting {
    var onConnected: (() -> ())?
    var onDisconnected: (() -> ())?
    var onPayload: ((String) -> ())?
    var send = false
    func send(_ string: String, completion: @escaping (Error?) -> ()) {
        send = true
    }
    
    func disconnect() {}
}
