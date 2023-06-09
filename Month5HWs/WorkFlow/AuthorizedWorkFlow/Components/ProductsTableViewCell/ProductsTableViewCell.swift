//
//  TableViewCell.swift
//  Month5HWs
//
//  Created by Jarae on 17/5/23.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {

    static let reuseId = String(describing: ProductsTableViewCell.self)
    static let nibName = String(describing: ProductsTableViewCell.self)
    
    @IBOutlet weak var imageTV: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    func display(item: Product) {
        title.text = item.title
        rating.text = String(item.rating)
        price.text = "\(item.price)$"
        desc.text = item.description
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let data = ImageDownloader(
                urlString: item.thumbnail
            ).donwload()
            else {
                return
            }
            DispatchQueue.main.async {
                self.imageTV.image = UIImage(data: data)
            }
        }
    }
    func display(item: CoreDataProduct) {
        title.text = item.name
        rating.text = "5.0"
        price.text = "\(item.price!)$"
        desc.text = item.productDescription
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let data = ImageDownloader(
                urlString: "https://img.freepik.com/free-photo/road-mountains-with-cloudy-sky_1340-23022.jpg"
            ).donwload()
            else {
                return
            }
            DispatchQueue.main.async {
                self.imageTV.image = UIImage(data: data)
            }
        }
    }
}
