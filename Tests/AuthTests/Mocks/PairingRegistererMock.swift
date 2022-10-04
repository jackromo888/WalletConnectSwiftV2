import Foundation
import WalletConnectPairing
import Combine
import WalletConnectNetworking

class PairingRegistererMock<RequestParams>: PairingRegisterer where RequestParams : Codable {

    let subject = PassthroughSubject<RequestSubscriptionPayload<RequestParams>, Never>()

    var isActivateCalled: Bool = false

    func register<RequestParams>(method: ProtocolMethod) -> AnyPublisher<RequestSubscriptionPayload<RequestParams>, Never> where RequestParams : Decodable, RequestParams : Encodable {
        subject.eraseToAnyPublisher() as! AnyPublisher<RequestSubscriptionPayload<RequestParams>, Never>
    }

    func activate(pairingTopic: String) {
        isActivateCalled = true
    }
    
    func validatePairingExistance(_ topic: String) throws {

    }
}