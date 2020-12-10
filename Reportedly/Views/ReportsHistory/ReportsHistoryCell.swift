//
//  ReportsHistoryCell.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/10/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

final class ReportsHistoryCell: UITableViewCell {

    private let reportDateLabel = UILabel()
    private let reportTasksTitleLabel = UILabel()
    private let reportTasksContentsLabel = UILabel()
    private let reportObstaclesTitleLabel = UILabel()
    private let reportObstaclesContentsLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setColors()
    }
}

// MARK: - Private helper
extension ReportsHistoryCell {

    private func setUpUI() {
        setUpLayouts()
        setUpViews()
        setColors()
    }

    private func setUpLayouts() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .spacer2
        stackView.addArrangedSubview(reportTasksTitleLabel)
        stackView.addArrangedSubview(reportTasksContentsLabel)
        stackView.addArrangedSubview(reportObstaclesTitleLabel)
        stackView.addArrangedSubview(reportObstaclesContentsLabel)

        contentView.addSubview(reportDateLabel)
        contentView.addSubview(stackView)

        reportDateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(CGFloat.spacer4)
            $0.trailing.top.equalToSuperview().inset(CGFloat.spacer4)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(CGFloat.spacer8)
            $0.trailing.bottom.equalToSuperview().inset(CGFloat.spacer4)
            $0.top.equalTo(reportDateLabel.snp.bottom).offset(CGFloat.spacer4)
        }
    }

    private func setUpViews() {
        reportDateLabel.font = .appBoldFont(ofSize: .medium)
        reportDateLabel.numberOfLines = 1

        reportTasksTitleLabel.font = .appBoldFont(ofSize: .small)
        reportTasksTitleLabel.numberOfLines = 2
        
        reportTasksContentsLabel.font = .appFont(ofSize: .xSmall)
        reportTasksContentsLabel.numberOfLines = 0
        
        reportObstaclesTitleLabel.font = .appBoldFont(ofSize: .small)
        reportObstaclesTitleLabel.numberOfLines = 2
        
        reportObstaclesContentsLabel.font = .appFont(ofSize: .xSmall)
        reportObstaclesContentsLabel.numberOfLines = 0
    }

    private func setColors() {
        backgroundColor = .clear
        contentView.backgroundColor = .forms
        
        reportDateLabel.textColor = .textPrimary
        
        reportTasksTitleLabel.textColor = .textPrimary
        
        reportTasksContentsLabel.textColor = .textPrimary
        
        reportObstaclesTitleLabel.textColor = .textPrimary
        
        reportObstaclesContentsLabel.textColor = .textPrimary
    }
}

// MARK: - Configurable
extension ReportsHistoryCell: Configurable {

    func configure(with viewModel: ReportsHistoryCellViewModel) {
        let formattedDateString = viewModel.reportDate.toString(withFormat: DateFormat.EEEE_MMMM_dd_YYYY)
        reportDateLabel.text = formattedDateString
        reportTasksTitleLabel.text = viewModel.reportTasksTitle
        reportTasksContentsLabel.text = viewModel.reportTasksContent
        reportObstaclesTitleLabel.text = viewModel.reportObstaclesTitle
        reportObstaclesContentsLabel.text = viewModel.reportObstaclesContent
    }
}
