import UIKit

class HeaderTableView: UIView {
    
    // MARK: Properties
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let textLabel: InsetLabel = {
        let textLabel = InsetLabel()
        textLabel.font = .preferredFont(forTextStyle: .title2)
        textLabel.textColor = .tintColor
        textLabel.textAlignment = .center
        textLabel.contentInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return textLabel
    }()

    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.cornerRadius = 10
        return blurView
    }()
    
    private var containerView = UIView()
    private var containerViewHeight = NSLayoutConstraint()
    private var imageViewHeight = NSLayoutConstraint()
    private var imageViewBottom = NSLayoutConstraint()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createViews()
        setViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Methods
    
    // check for scroll, resize image
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offSetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offSetY <= 0
        imageViewBottom.constant = offSetY >= 0 ? 0 : -offSetY / 2
        imageViewHeight.constant = max(offSetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
    
    // MARK: Private Methods
    // Create subviews
    private func createViews() {
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(blurView)
        containerView.addSubview(textLabel)
    }
    
    // Set constraints
    private func setViewConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: containerView.widthAnchor),
            centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        
        imageViewBottom = imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        imageViewBottom.isActive = true
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: self.heightAnchor)
        imageViewHeight.isActive = true
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),

        ])
        
//        NSLayoutConstraint.activate([
//          blurView.topAnchor.constraint(equalTo: textLabel.topAnchor),
//          blurView.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
//          blurView.heightAnchor.constraint(equalTo: textLabel.heightAnchor),
//          blurView.widthAnchor.constraint(equalTo: textLabel.widthAnchor)
//        ])
        NSLayoutConstraint.activate([
          blurView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
          blurView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
          blurView.heightAnchor.constraint(equalTo: textLabel.heightAnchor),
          blurView.widthAnchor.constraint(equalTo: textLabel.widthAnchor)
        ])
    }
}
