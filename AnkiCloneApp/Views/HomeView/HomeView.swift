import EventBus
import SnapKit
import UIKit

final class HomeView: UIView, RootView {
    
    private lazy var settingButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "gearshape")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var floatingButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        let image = UIImage(systemName: "plus")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowColor = UIColor.black.cgColor
        return button
    }()
    
    private lazy var writeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        let image = UIImage(systemName: "pencil")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowColor = UIColor.black.cgColor
        button.alpha = 0
        
        return button
    }()
    
    private var isActive: Bool = false {
        didSet {
            showActionButtons()
        }
    }
    
    private var animation: UIViewPropertyAnimator?
    
    func initializeUI() {
        backgroundColor = .systemBackground
        
        
        setUI()
        
        bringSubviewToFront(floatingButton)
        bringSubviewToFront(writeButton)
    }
    
    private func setUI() {
        addSubview(settingButton)
        addSubview(floatingButton)
        addSubview(writeButton)
        
        settingButton.snp.makeConstraints { make in
            make.width.equalTo(37)
            make.height.equalTo(37)
            make.left.equalToSuperview().offset(330)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(0)
        }
        
        floatingButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.bottomMargin.equalToSuperview().offset(-40)
            make.rightMargin.equalToSuperview().offset(-20)
        }
        
        writeButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.bottom.equalTo(floatingButton.snp.top).offset(-15)
            make.rightMargin.equalToSuperview().offset(-20)
        }
        
    }
    @objc private func didTapSettingButton() {
        print("settingButtonTapped")
        EventBus.shared.emit(PushToSettingScreenEvent())
    }
    
    @objc private func didTapFloatingButton() {
        isActive.toggle()
    }
    
    private func showActionButtons() {
        popButtons()
        rotateFloatingButton()
    }
    
    private func popButtons() {
        if isActive {
            writeButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
            UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.3, options: [.curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                self.writeButton.layer.transform = CATransform3DIdentity
                self.writeButton.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.15, delay: 0.2, options: []) { [weak self] in
                guard let self = self else { return }
                self.writeButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 0.1)
                self.writeButton.alpha = 0.0
            }
        }
    }
    
    private func rotateFloatingButton() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        let fromValue = isActive ? 0 : CGFloat.pi / 4
        let toValue = isActive ? CGFloat.pi / 4 : 0
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = 0.3
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        floatingButton.layer.add(animation, forKey: nil)
    }
}



