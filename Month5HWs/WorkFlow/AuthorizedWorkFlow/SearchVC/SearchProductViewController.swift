//
//  SearchProductViewController.swift
//  Month5HWs
//
//  Created by Jarae on 3/6/23.
//

import UIKit

class SearchProductViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productsTableView: UITableView!
    
    
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var products: [CoreDataProduct] = []
    private var filteredProducts: [CoreDataProduct] = []
    private var isFiltered: Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getAllProducts()
    }

    func configureTableView() {
        productsTableView.dataSource = self
        productsTableView.delegate = self
        productsTableView.register(
            UINib(
                nibName: ProductsTableViewCell.nibName,
                bundle: nil
            ),
            forCellReuseIdentifier: ProductsTableViewCell.reuseId
        )
    }
    
    private func filterProducts(with text: String) {
        filteredProducts = products.filter {
            $0.name!.lowercased()
            .contains(
                text.lowercased()
            )
        }
        productsTableView.reloadData()
    }
    
    func getAllProducts() {
        do {
            products = try contex.fetch(CoreDataProduct.fetchRequest())
            DispatchQueue.main.async {
                self.productsTableView.reloadData()
            }
        } catch {
            //error
        }
    }
    
    func createProduct(name: String, price: String, desc: String) {
        let newProduct = CoreDataProduct(context: contex)
        newProduct.name = name
        newProduct.price = price
        newProduct.productDescription = desc
        
        do {
            try contex.save()
        } catch {
            //error
        }
    }
    
    func deleteProduct(item: CoreDataProduct) {
        contex.delete(item)
        do {
            try contex.save()
            getAllProducts()
        } catch {
            //error
        }
    }
}

//MARK: - TableView DataSource / Delegate
extension SearchProductViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        isFiltered ? filteredProducts.count : products.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductsTableViewCell.reuseId,
            for: indexPath
        ) as! ProductsTableViewCell
        
        let model = isFiltered
        ? filteredProducts[indexPath.row]
        : products[indexPath.row]
        cell.display(item: model)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        330
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = products[indexPath.row]
        let sheet = UIAlertController(
            title: "Edit",
            message: nil,
            preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.deleteProduct(item: item)
        }))
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(sheet, animated: true)
    }
}
//MARK: - UISearchBarDelegates
extension SearchProductViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        isFiltered = !searchText.isEmpty
        filterProducts(with: searchText)
    }
}
