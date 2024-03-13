import Foundation

public protocol StatisticGoalInterface {
    init ()
    func create(_ day: Date, seconds: Int, goal: Bool, upload: Bool)
    func upload(_ entity: StatisticGoal, goal: Bool, seconds: Int, upload: Bool)
    func read(_ day:  Date) -> StatisticGoal?
    func readAll() -> [StatisticGoal]
    func delete(_ entity: StatisticGoal)


    // essa funcao vai checar se hoje a meta foi batica caso nao o botao continua vermelho caso sim verifica se ja foi upado caso nao tenha sido ele upa e modifica para upado e fica verde
}
