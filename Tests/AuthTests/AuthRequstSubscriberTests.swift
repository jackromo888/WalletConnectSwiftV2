import Foundation
import XCTest
@testable import Auth
import WalletConnectUtils
@testable import WalletConnectKMS
@testable import TestingUtils
import JSONRPC

class AuthRequstSubscriberTests: XCTestCase {
    var networkingInteractor: NetworkingInteractorMock!
    var sut: WalletRequestSubscriber!
    var messageFormatter: SIWEMessageFormatterMock!
    let defaultTimeout: TimeInterval = 0.01

    override func setUp() {
        networkingInteractor = NetworkingInteractorMock()
        messageFormatter = SIWEMessageFormatterMock()
        sut = WalletRequestSubscriber(networkingInteractor: networkingInteractor,
                                   logger: ConsoleLoggerMock(),
                                    messageFormatter: messageFormatter, address: "")
    }

    func testSubscribeRequest() {
        let expectedMessage = "Expected Message"
        let expectedRequestId: RPCID = RPCID(1234)
        let messageExpectation = expectation(description: "receives formatted message")
        messageFormatter.formattedMessage = expectedMessage
        var messageId: RPCID!
        var message: String!
        sut.onRequest = { id, result in
            guard case .success(let formattedMessage) = result else { return XCTFail() }
            messageId = id
            message = formattedMessage
            messageExpectation.fulfill()
        }

        networkingInteractor.requestPublisherSubject.send(RequestSubscriptionPayload.stub(id: expectedRequestId))

        wait(for: [messageExpectation], timeout: defaultTimeout)
        XCTAssertEqual(message, expectedMessage)
        XCTAssertEqual(messageId, expectedRequestId)
    }
}
