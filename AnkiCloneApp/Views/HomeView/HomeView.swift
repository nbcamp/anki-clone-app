import EventBus
import SnapKit
import UIKit

final class HomeView: UIView, RootView {
    private(set) var decks: [Deck] = []

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
        button.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(didTapWriteButton), for: .touchUpInside)
        return button
    }()

    private lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 150, height: 210)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CircleCell.self, forCellWithReuseIdentifier: "circleCell")
        collectionView.register(
            HomeCollectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeCollectionHeaderView.name
        )

        return collectionView
    }()

    private var isActive: Bool = false {
        didSet {
            showActionButtons()
        }
    }

    private var animation: UIViewPropertyAnimator?

    func configure(with decks: [Deck]) {
        self.decks = decks
        homeCollectionView.reloadData()
    }

    func initializeUI() {
        backgroundColor = .systemBackground

        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.allowsSelection = true

        setUI()

        bringSubviewToFront(floatingButton)
        bringSubviewToFront(writeButton)
    }

    private func setUI() {
        addSubview(homeCollectionView)
        homeCollectionView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(30)
        }

        addSubview(floatingButton)
        floatingButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.bottomMargin.equalToSuperview().offset(-40)
            make.rightMargin.equalToSuperview().offset(-20)
        }

        addSubview(writeButton)
        writeButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.bottom.equalTo(floatingButton.snp.top).offset(-15)
            make.rightMargin.equalToSuperview().offset(-20)
        }
    }

    @objc private func didTapFloatingButton() {
        isActive.toggle()
    }

    @objc private func didTapWriteButton() {
        EventBus.shared.emit(ShowCreateNewDeckAlertEvent(payload: { [weak self] _ in
            self?.homeCollectionView.reloadData()
        }))
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

extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return decks.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeCollectionHeaderView.name, for: indexPath) as? HomeCollectionHeaderView {
                header.settingButtonTapped = {
                    EventBus.shared.emit(MoveToSettingScreenEvent())
                }
                return header
            }
        }
        fatalError("Unknown supplementary element of kind")
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "circleCell", for: indexPath) as! CircleCell
        cell.configure(with: decks[indexPath.row])
        cell.deleteButtonTapped = deleteButtonTapped
        return cell
    }

    private func deleteButtonTapped(_ cell: CircleCell) {
        guard let indexPath = homeCollectionView.indexPath(for: cell) else { return }
        EventBus.shared.emit(ShowDeleteDeckAlertEvent(payload: .init(deck: decks[indexPath.item]) { [weak self] in
            guard let self, let indexPath = self.homeCollectionView.indexPath(for: cell) else { return }
            decks.remove(at: indexPath.row)
            homeCollectionView.deleteItems(at: [indexPath])
        }))
    }
}

extension HomeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        EventBus.shared.emit(MoveToDeckScreenEvent(payload: .init(deck: decks[indexPath.item])))
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: collectionView.bounds.width, height: 100)
    }
}
