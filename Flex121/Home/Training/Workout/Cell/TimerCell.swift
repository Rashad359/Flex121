//
//  TimerCell.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/24/25.
//

import UIKit

class TimerCell: UITableViewCell {
    
    private var timer: Timer = Timer()
    private var count: Int = 0
    private var timerCounting: Bool = false
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .underline
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let stopWatch: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = UIFont(name: Fonts.EuclidSemibold.fontName, size: 28)
        label.textColor = .white
        return label
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.pause, for: .normal)
        button.backgroundColor = .brightGreen
        button.layer.cornerRadius = 20
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapStop), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.play, for: .normal)
        button.backgroundColor = .brightGreen
        button.tintColor = .black
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
        
        return button
    }()
    
    private let mainStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private let buttonStackView: BaseHorizontalStackView = {
        let stackView = BaseHorizontalStackView()
        stackView.spacing = 12
        return stackView
    }()
    
    @objc
    private func didTapStop() {
        self.count = 0
        self.timer.invalidate()
        self.stopWatch.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
    }
    
    @objc
    private func didTapPlay() {
        if timerCounting {
            timerCounting = false
            timer.invalidate()
            playButton.setImage(.play, for: .normal)
        } else {
            timerCounting = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            playButton.setImage(.pause, for: .normal)
        }
    }
    
    @objc
    private func timerCounter() {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        stopWatch.text = timeString
    }
    
    private func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    private func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(backView)
        backView.addSubview(mainStackView)
        
        backView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalToSuperview() //Change it later on
            make.top.equalToSuperview().offset(32)
        }
        
        [stopWatch, buttonStackView].forEach(mainStackView.addArrangedSubview)
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(24)
        }
        
        [stopButton, playButton].forEach(buttonStackView.addArrangedSubview)
        
        playButton.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
        
        stopButton.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
