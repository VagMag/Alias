import UIKit

class RulesViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: Properties
    var sectionTitles = [String]()
    var sectionRows = [[String]]()

    var editUserInfoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        return button
    }()
    
    var buttonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "LightBlueColor")
        return view
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BlueColor")
        setTableView()
        setHeader()
        view.addSubview(tableView)
        hideKeyboardOnTap()
        view.bringSubviewToFront(closeButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        editUserInfoButton.layer.cornerRadius = editUserInfoButton.frame.width / 2
        sectionTitles = Rules.titles
        sectionRows = Rules.paragraphs
        tableView.reloadData()
    }

    // MARK: Override Methods
    
    // Light Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    // MARK: Public Methods
    
    @objc func hideKeyboard() {
        tableView.endEditing(true)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true)

    }
    
    // MARK: Private Methods
    
    private func setTableView() {
        tableView.backgroundColor = UIColor(named: "BlueColor")
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.frame = view.bounds
        tableView.separatorStyle = .none
    }
    
    private func setHeader() {
        let header = HeaderTableView(frame: CGRect(x: 0, y: 0,
                                                   width: view.frame.width,
                                                   height: view.frame.width * 2 / 3))
        header.imageView.image = UIImage(named: "StreetImage")
        tableView.tableHeaderView = header
    }
    
    private func hideKeyboardOnTap() {
        tableView.keyboardDismissMode = .onDrag
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture)
    }
}

// MARK: - Extensions

extension RulesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .gray
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionRows.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionRows[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InfoCell
        cell.infoLabel.text = sectionRows[indexPath.section][indexPath.row]
        
        cell.containerView.layer.cornerRadius = 20
        
        // fancy rounded corners
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.containerView.layer.maskedCorners = [.layerMinXMinYCorner]
                return cell
            } else {
                cell.containerView.layer.maskedCorners = [.layerMaxXMaxYCorner]
                return cell
            }
        }
        cell.containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        return cell
    }
}

extension RulesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension RulesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? HeaderTableView else { return }
        header.scrollViewDidScroll(scrollView: tableView)
    }
}
