//
//  TableViewController.swift
//  Reddit
//
//  Created by Jackson Barnes on 9/3/21.
//

import UIKit

class TableViewController: UITableViewController {
    @IBOutlet weak var redditSearchBar: UISearchBar!
    var manager = PostManager()
    var posts: [Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.fetchPosts(for: "all")
        redditSearchBar.delegate = self

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    //defines what each cell at each address looks like
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        let post = posts[indexPath.row]//get post that coresponds to the row
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = "❤️\(post.ups) 💬\(post.numComments) 🎖\(post.totalAwardsReceived)"
        // Configure the cell...

        return cell
    }
}
    extension TableViewController: PostManagerDelegate{
        func didFetchPosts(posts: [Post]) {
            DispatchQueue.main.async {
                self.posts = posts
                self.tableView.reloadData()
            }
        }
        
        func didFail(error: Error?) {
            print(error as Any)
        }
    }
extension TableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let subreddit = searchBar.text else {return}
        manager.fetchPosts(for: subreddit)
        searchBar.text = ""
    }
}
