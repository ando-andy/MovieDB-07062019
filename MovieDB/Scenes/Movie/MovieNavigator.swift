
protocol MovieNavigatorType {

}

struct MovieNavigator: MovieNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
