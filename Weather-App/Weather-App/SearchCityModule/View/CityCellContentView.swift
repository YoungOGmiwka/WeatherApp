//
//  CityCellContentView.swift
//  Weather-App
//
//  Created by Михаил on 27.09.2023.
//

import Foundation
import UIKit
import SnapKit

final class CityCellContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration {
        didSet { self.configure() }
    }
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "DefaultTextColor")
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "DefaultTextColor")
        return label
    }()
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        
        super.init(frame: .zero)
        
        addSubview(cityLabel)
        addSubview(temperatureLabel)
        
        cityLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let model = configuration as? CityCellModel else { return }
        cityLabel.text = model.city
        temperatureLabel.text = model.temperature
    }
}
