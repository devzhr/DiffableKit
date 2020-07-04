import UIKit

class DiffableTableController: SPDiffableTableController, SPTableDiffableMediator {
    
    init() {
        super.init(style: .insetGrouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(NativeTableViewCell.self, forCellReuseIdentifier: NativeTableViewCell.identifier)
        setCellProviders([CellProvider.default], sections: content)
        diffableDataSource?.mediator = self
    }
    
    var content: [SPDiffableSection] {
        return []
    }
    
    internal func updateContent(animating: Bool) {
        diffableDataSource?.apply(sections: content, animating: animating)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch diffableDataSource?.itemIdentifier(for: indexPath) {
        case let model as SPDiffableTableRow:
            model.action?(indexPath)
        default:
            break
        }
    }
    
    enum CellProvider {
        
        static var `default`: SPDiffableTableCellProvider {
            let cellProvider: SPDiffableTableCellProvider = { (tableView, indexPath, item) -> UITableViewCell? in
                switch item {
                case let item as SPDiffableTableRow:
                    let cell = tableView.dequeueReusableCell(withIdentifier: NativeTableViewCell.identifier, for: indexPath) as! NativeTableViewCell
                    cell.textLabel?.text = item.text
                    cell.detailTextLabel?.text = item.detail
                    cell.accessoryType = item.accessoryType
                    cell.selectionStyle = item.selectionStyle
                    return cell
                case let item as SPDiffableTableRowSwitch:
                    let cell = tableView.dequeueReusableCell(withIdentifier: NativeTableViewCell.identifier, for: indexPath) as! NativeTableViewCell
                    cell.textLabel?.text = item.text
                    let control = ActionableSwitch(action: item.action)
                    control.isOn = item.isOn
                    cell.accessoryView = control
                    cell.selectionStyle = .none
                    return cell
                case let item as SPDiffableTableRowStepper:
                    let cell = tableView.dequeueReusableCell(withIdentifier: NativeTableViewCell.identifier, for: indexPath) as! NativeTableViewCell
                    cell.textLabel?.text = item.text
                    let control = ActionableStepper(action: item.action)
                    control.value = Double(item.value)
                    control.minimumValue = Double(item.minimumValue)
                    control.maximumValue = Double(item.maximumValue)
                    cell.accessoryView = control
                    cell.selectionStyle = .none
                    return cell
                default:
                    return nil
                }
            }
            return cellProvider
        }
    }
}
