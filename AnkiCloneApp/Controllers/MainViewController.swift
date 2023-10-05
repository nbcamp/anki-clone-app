import EventBus
import UIKit

struct PopViewControllerEvent: EventProtocol {
    struct Payload {
        let viewController: UIViewController
        let animated = true
    }

    let payload: Payload
}

final class MainViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([HomeViewController()], animated: false)
        EventBus.shared.on(PopViewControllerEvent.self, by: self) { _, payload in
            payload.viewController.navigationController?.popViewController(animated: payload.animated)
        }
    }
}
