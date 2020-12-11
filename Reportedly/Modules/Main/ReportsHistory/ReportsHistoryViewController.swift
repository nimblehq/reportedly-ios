//
//  ReportsHistoryViewController.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/10/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

// sourcery: AutoMockable
protocol ReportsHistoryViewInput: AnyObject, CommonViewInput {

    func configure()
    func hideNoReportLabel()
    func update(with reports: [Report])
}

// sourcery: AutoMockable
protocol ReportsHistoryViewOutput: AnyObject {

    func viewDidLoad()
    func viewWillAppear()
    
    func didTapRefreshRightNavBarButtonItem()
}

final class ReportsHistoryViewController: ViewController {

    private let backgroundImageView = UIImageView()
    private let transparentLayerView = UIView()
    
    private let emptyReportLabel = UILabel()
    private let reportsHistoryTableView = UITableView()
    private var reportsHistoryCellViewModels: [ReportsHistoryCellViewModel] = []
    
    var output: ReportsHistoryViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewWillAppear()
    }
    
    override func setUpColors() {
        super.setUpColors()
        view.backgroundColor = .background
        
        transparentLayerView.backgroundColor = .overlayLight
        
        reportsHistoryTableView.backgroundColor = .clear
        
        emptyReportLabel.textColor = .primary
    }
    
    override func setUpTexts() {
        super.setUpTexts()
        title = Localize.moduleReportsHistoryReportsHistoryTitle.localized()
        
        emptyReportLabel.text = Localize.moduleReportsHistoryNoReportText.localized()
    }
}

// MARK: - ReportsHistoryViewInput

extension ReportsHistoryViewController: ReportsHistoryViewInput {

    func configure() {
        setUpLayouts()
        setUpViews()
        setUpNavigationBar()
    }
    
    func hideNoReportLabel() {
        emptyReportLabel.isHidden = true
    }
    
    func update(with reports: [Report]) {
        reportsHistoryCellViewModels = reports.map {
            ReportsHistoryCellViewModel(
                date: $0.date,
                tasks: $0.tasks,
                obstacles: $0.obstacles
            )
        }.sorted { $0.reportDate > $1.reportDate }
        let isNoReport = reportsHistoryCellViewModels.isEmpty
        reportsHistoryTableView.isHidden = isNoReport
        emptyReportLabel.isHidden = !isNoReport
        reportsHistoryTableView.reloadData()
    }
}

// MARK: - Actions

extension ReportsHistoryViewController {
    
    @objc private func didTapRefreshRightNavBarButtonItem() {
        output?.didTapRefreshRightNavBarButtonItem()
    }
}

// MARK: - Configure

extension ReportsHistoryViewController {
    
    private func setUpLayouts() {
        view.addSubview(backgroundImageView)
        view.addSubview(transparentLayerView)
        view.addSubview(reportsHistoryTableView)
        view.addSubview(emptyReportLabel)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        transparentLayerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        reportsHistoryTableView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.snp.topMargin)
        }
        
        emptyReportLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(CGFloat.spacer4)
        }
    }
    
    private func setUpViews() {
        setUpBackgroundImageView()
        setUpReportsHistoryTableView()
        setUpRmptyReportLabel()
    }
    
    private func setUpNavigationBar() {
        addRefreshRightNavBarButtonItem()
    }
}

// MARK: - Main View

extension ReportsHistoryViewController {
    
    private func setUpBackgroundImageView() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = Asset.background.reportsHistoryScreen()
    }
    
    private func setUpReportsHistoryTableView() {
        reportsHistoryTableView.delegate = self
        reportsHistoryTableView.dataSource = self
        reportsHistoryTableView.contentInset = UIEdgeInsets(top: .spacer4, left: 0, bottom: .spacer7, right: 0)
        reportsHistoryTableView.register(ReportsHistoryCell.self)
        reportsHistoryTableView.separatorStyle = .none
        reportsHistoryTableView.rowHeight = UITableView.automaticDimension
        reportsHistoryTableView.alwaysBounceVertical = true
    }
    
    private func setUpRmptyReportLabel() {
        emptyReportLabel.isHidden = true
        emptyReportLabel.textAlignment = .center
        emptyReportLabel.font = UIFont.appBoldFont(ofSize: .regular)
    }
    
    private func addRefreshRightNavBarButtonItem() {
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefreshRightNavBarButtonItem))
        navigationItem.rightBarButtonItems = [refresh]
    }
}

// MARK: - UITableView DataSource
extension ReportsHistoryViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportsHistoryCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ReportsHistoryCell.self, for: indexPath)

        let model = reportsHistoryCellViewModels[indexPath.row]
        cell.configure(with: model)

        return cell
    }
}

// MARK: - UITableView Delegate
extension ReportsHistoryViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = reportsHistoryCellViewModels[indexPath.row]
        log.debug("Selected report: \(model)")
    }
}
