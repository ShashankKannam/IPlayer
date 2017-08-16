//
//  LibraryViewController.swift
//  IPlayer
//
//  Created by Shashank Kannam on 8/15/17.
//  Copyright © 2017 Shashank Kannam. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var titleLBL: UILabel!
    
    private var activityIndicator: UIActivityIndicatorView!
    
    private var albums = [Album]() {
        didSet { tableView?.reloadData() }
    }
    
    //MARK: - ViewCycleMethods

    override func viewDidLoad() {
        super.viewDidLoad()

        let albumNib = UINib(nibName: AlbumTableViewCell.nibName(), bundle: nil)
        tableView.register(albumNib, forCellReuseIdentifier: AlbumTableViewCell.reuseID())
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        
        hideKeyboardWhenTappedAround()
        activityIndicator = activityIndicatorSetup(viewTo: view)
        
    }
    
    //MARK: - IBAction
    
    @IBAction func searchButtonPressed(_ sender: CustomUIButton) {
        searchBar.isHidden = false
        tableView.isHidden = false
        searchBar.becomeFirstResponder()
        searchBtn.isHidden = true
    }
    
    //MARK: - TableViewDatasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let albumCell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.reuseID()) as? AlbumTableViewCell else { return UITableViewCell() }
        albumCell.configureCell(album: albums[indexPath.row])
        return albumCell
    }
    
    //MARK: - TableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("In Here")
        performSegue(withIdentifier: "toPlayerVC", sender: indexPath)
    }

//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let cell = cell as? AlbumTableViewCell else { return }
//        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
//            cell.albumImageView.center.x += cell.contentView.bounds.width
//            cell.trackNameLBL.center.x += cell.contentView.bounds.width
//            cell.collectionNameLBL.center.x += cell.contentView.bounds.width
//        }, completion: nil)
//    }
    
    //MARK: - SearchBarMethods
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        titleLBL.text = App_Title
        tableView.reloadData()
        searchBar.text = nil
        searchBar.isHidden = true
        searchBtn.isHidden = false
        tableView.isHidden = true
        view.endEditing(true)
        activityIndicator.stopAnimating()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        titleLBL.text = searchText.isEmpty ? App_Title : searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let userInput = searchBar.text, !userInput.isEmpty {
            let trimmedUserInput = userInput.lowercased().trimmingCharacters(in: .whitespaces)
            fetchData(userInputIn: trimmedUserInput)
        }
        view.endEditing(true)
    }
    
    //MARK: - fetchData

    private func fetchData(userInputIn: String) {
        albums = [Album]()
        activityIndicator.startAnimating()
        IPlayerWebRequest.shared.getDatafromURL(albumsURL: "\(Albums_Request_URL)\(userInputIn)") { [weak self] (result) in
            if result.error == nil, let data = result.data {
                DispatchQueue.main.async {
                    self?.albums = AlbumParser.getAlbums(parseWithData: data)
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    //MARK: - SegueMethods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlayerVC", let destination = segue.destination as? PlayerViewController, let albumIndex = sender as? IndexPath
        {
            destination.album = albums[albumIndex.row]
        }
    }
   
}
