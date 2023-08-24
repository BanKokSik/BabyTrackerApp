//
//  EventFeedViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 9.08.23.
//

import UIKit

class EventFeedViewController: BaseViewController {
    
    weak var coordinator: Coordinator?
    private var eventFeedCoordinator: EventFeedCoordinator? { coordinator as? EventFeedCoordinator }
    
    var presenter: EventFeedPresenter?
    
    private lazy var dateFormatter: DateFormatter = _dateFormatter
    private lazy var dateLabel: UILabel = _dateLabel
    private lazy var tableView: UITableView = _tableView
    private lazy var plusButton: UIButton = _plusButton
    
    let icons = EventFeedModule.icons
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = EventFeedPresenter()
        
        addSubviews()
        applyConstraints()
        setupDate()
    }
    
    private func setupDate() {
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        dateLabel.text = formattedDate
    }
    
    private func addSubviews() {
        view.addSubview(dateLabel)
        view.addSubview(tableView)
        view.addSubview(plusButton)
    }
    
    private func applyConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.leading.equalToSuperview().inset(30)
            make.trailing.equalToSuperview().inset(216)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(115)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(420)
        }
        
        plusButton.snp.makeConstraints { make in
            make.height.equalTo(53)
            make.width.equalTo(55)
            make.bottom.equalToSuperview().inset(150)
            make.centerX.equalToSuperview()
        }
    }
}


extension EventFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseIdentifier, for: indexPath) as! FeedTableViewCell
        
        presenter?.setupCells(for: cell, index: indexPath.row)
        presenter?.setupSeparator(for: cell, index: indexPath.row)
        
        let icon = icons[indexPath.row].image
        cell.setIcon(icon)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter!.getHeightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension EventFeedViewController {
    
    var _dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter
    }
    
    var _dateLabel: UILabel {
        let label = UILabel()
        label.font = Fonts.gilroyMedium18
        label.textColor = .lightGray
        return label
    }
    
    var _tableView: UITableView {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.reuseIdentifier)
        return tableView
    }
    
    var _plusButton: UIButton {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.setBackgroundColor(R.color.heliotrope(), for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = Fonts.gilroyMedium32
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }
}
