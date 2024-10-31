import UIKit

protocol TableManagement: AnyObject {
    func attach(_ tableView: UITableView)
    func update(with configurators: [TableCellConfiguration])
}

final class TableManager: NSObject, TableManagement {
    private var configurators = [TableCellConfiguration]()
    private weak var tableView: UITableView?
    var selectedIndexPath: IndexPath?

    func attach(_ tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        
        let cellID = String(describing: TableViewCell.self)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellID)
        
        tableView.bounces = false
        tableView.isUserInteractionEnabled = true
        self.tableView = tableView
    }

    func update(with configurators: [TableCellConfiguration]) {
        self.configurators = configurators
        tableView?.reloadData()
    }
}

extension TableManager: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configurators.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configurator = configurators[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: configurator.cellIdentifier, for: indexPath)
        configurator.configureCell(cell)
        return cell
    }
}

extension TableManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selected = selectedIndexPath, selected != indexPath {
            return nil
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let configurator = configurators[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedIndexPath = nil
        configurator.didTapCell?()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let configurator = configurators[indexPath.row]
    }
}
