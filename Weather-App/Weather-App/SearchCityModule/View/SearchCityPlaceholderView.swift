//
//  SearchCityPlaceholderView.swift
//  Weather-App
//
//  Created by Михаил on 27.09.2023.
//

import Foundation
import UIKit
import SnapKit

final class SearchCityPlaceholderView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "SearchViewControllerPlaceholder")
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "У Вас ещё нет выбранных городов"
        label.textColor = UIColor(named: "PlaceholderTextColor")
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(imageView)
        addSubview(textLabel)
        imageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 200, height: 122))
            $0.center.equalToSuperview()
        }
        textLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
