import UIKit
import WalletConnect

final class ResponderViewController: UIViewController {

    let client: WalletConnectClient = {
        let options = WalletClientOptions(
            apiKey: "",
            name: "Example",
            isController: true,
            metadata: AppMetadata(name: "Example App", description: nil, url: nil, icons: nil),
            relayURL: URL(string: "wss://staging.walletconnect.org")!)
        return WalletConnectClient(options: options)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Wallet"
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "qrcode.viewfinder"),
            style: .plain,
            target: self,
            action: #selector(showScanner)
        )
    }
    
    @objc
    private func showScanner() {
//        let scannerViewController = ScannerViewController()
//        scannerViewController.delegate = self
//        navigationController?.pushViewController(scannerViewController, animated: true)
        showSessionProposal()
    }
    
    private func showSessionProposal() {
        let proposalViewController = SessionViewController()
        proposalViewController.show(SessionInfo.mock())
        present(proposalViewController, animated: true)
    }
}

extension ResponderViewController: ScannerViewControllerDelegate {
    
    func didScan(_ code: String) {
        navigationController?.popToViewController(self, animated: true)
        print(code)
        // TODO: Start pairing
    }
}
