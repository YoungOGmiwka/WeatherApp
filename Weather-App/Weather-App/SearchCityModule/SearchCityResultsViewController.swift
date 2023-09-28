//
//  SearchCityResultsViewController.swift
//  Weather-App
//
//  Created by Михаил on 27.09.2023.
//

import Foundation
import UIKit

protocol SearchCityResultsViewControllerDataSource: AnyObject {
    var items: [CityCellModel] { get }
}

final class SearchCityResultsViewController: UIViewController {
    
    weak var itemsDataSource: SearchCityResultsViewControllerDataSource?

    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout.list(using: UICollectionLayoutListConfiguration(appearance: .insetGrouped))
    )
    
    private let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, CityCellModel> { cell, _, item in
        cell.contentConfiguration = item
    }
    
    private lazy var dataSource = UICollectionViewDiffableDataSource<Int, CityCellModel>(collectionView: collectionView) { collectionView, indexPath, item in
        collectionView.dequeueConfiguredReusableCell(
            using: self.cellRegistration,
            for: indexPath,
            item: item
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        applySnapshot()
    }
    
    func configure() {
        applySnapshot()
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CityCellModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(itemsDataSource?.items ?? [], toSection: 0)
        dataSource.apply(snapshot)
    }
}

extension SearchCityResultsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = itemsDataSource?.items[indexPath.row] else { return }
        let detailsCityViewController = DetailCityAssembly().assemble(for: item)
        present(detailsCityViewController, animated: true)
    }
}
