//
//  ViewController.swift
//  SearchSongs
//
//  Created by Алексей Каземиров on 3/22/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    let networkDataFetcher = NetworkDataFetcher()
    let networkService = NetworkService()
    var searchResponce: SearchResponse? = nil
    private var timer: Timer?
    
    @IBOutlet weak var table: UITableView!
    let searchCOntroller = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Settings", for: .normal)
        button.backgroundColor = .systemIndigo
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(tap2), for: .touchDown)
        
        
        setupTableView()
        setupSearchBar()
        
    }
    
    @objc func tap2() {
        
    }
    
    @objc func tapped() {
        let vc = UIHostingController(rootView: SwiftUIView())
        present(vc, animated: true)
    }
    
    
    private func setupSearchBar() {
        navigationItem.searchController = searchCOntroller
        searchCOntroller.searchBar.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        searchCOntroller.obscuresBackgroundDuringPresentation = false
    }
    
    private func setupTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponce?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let track = searchResponce?.results[indexPath.row]
        let urlDefault = "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ae/4c/d4/ae4cd42a-80a9-d950-16f5-36f01a9e1881/source/60x60bb.jpg"
        cell.imageView?.imageFromURL(urlString: track?.artworkUrl60 ?? urlDefault, PlaceHolderImage: UIImage(named: "imagename")!)
        cell.textLabel?.text = track?.trackName ?? "No name song"
        cell.backgroundColor = .systemGreen
        return cell
    }
    
    
}

extension UIImageView {

 public func imageFromURL(urlString: String, PlaceHolderImage:UIImage) {

        if self.image == nil{
              self.image = PlaceHolderImage
        }

        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })

        }).resume()
    }}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let urlString = "https://itunes.apple.com/search?term=\(searchText)&limit=20"
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchTracks(urlString: urlString) { (searchResponce) in
                guard let searchResponce = searchResponce else {return}
                self.searchResponce = searchResponce
                self.table.reloadData()
            }
        })
    }
}

