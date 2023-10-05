import UIKit

final class StudyViewController: RootViewController<StudyView> {
    
    private let studyView = StudyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
