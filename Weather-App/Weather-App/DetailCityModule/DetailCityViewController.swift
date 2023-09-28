//
//  DetailCityViewController.swift
//  Weather-App
//
//  Created by Михаил on 28.09.2023.
//

import Foundation
import UIKit
import SnapKit

protocol IDetailCityView: AnyObject {
    func configure(with model: CityCellModel)
}

class DetailCityViewController: UIViewController, IDetailCityView {

    // Dependencies
    var presenter: IDetailCityPresenter?

    // UI
    lazy var labelCityName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    lazy var labelTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "Сейчас:  "
        return label
    }()
    
    lazy var currentTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    lazy var maxTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Макс: -"
        return label
    }()
    
    lazy var minTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Мин: -"
        return label
    }()
    
    lazy var nextThreeDays: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ближайшие 3 дня", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.addTarget(self, action: #selector(buttonTapThreeDays), for: .touchUpInside)
        return button
    }()
    
    lazy var nextWeek: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ближайшая неделя", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.addTarget(self, action: #selector(buttonTapWeek), for: .touchUpInside)
        return button
    }()

    // MARK: - Actions

    @objc func buttonTapThreeDays() {
        presenter?.didTapShowThreeDays()
    }
    
    @objc func buttonTapWeek() {
        presenter?.didTapShowWeek()
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
        presenter?.viewDidLoad()
        view.backgroundColor = UIColor(named: "PlaceholderTextColor")
    }

    // MARK: - IDetailCityView

    func configure(with model: CityCellModel) {
        labelCityName.text = model.city
        currentTemp.text = model.temperature
    }

    // MARK: - Private

    private func setupViewLayout() {
        view.addSubview(labelCityName)
        view.addSubview(currentTemp)
        view.addSubview(labelTemp)
        view.addSubview(maxTemp)
        view.addSubview(minTemp)
        view.addSubview(nextThreeDays)
        view.addSubview(nextWeek)
        
        labelCityName.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(120)
        }
        
        labelTemp.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(labelCityName.snp.bottom).offset(15)
        }
        
        currentTemp.snp.makeConstraints {
            $0.right.equalTo(labelTemp.snp.right).offset(20)
            $0.top.equalTo(labelCityName.snp.bottom).offset(15)
        }
        
        maxTemp.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(140)
            $0.top.equalTo(currentTemp.snp.bottom).offset(20)
        }

        minTemp.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(135)
            $0.top.equalTo(currentTemp.snp.bottom).offset(20)
        }

        nextThreeDays.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(currentTemp.snp.bottom).offset(60)
        }

        nextWeek.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(currentTemp.snp.bottom).offset(60)
        }
    }
}
