import Foundation

protocol StatisticRepository {
    init ()
    func addSecondsToday(today: Date, seconds: Int)
    func isGoalToday() -> Bool
    // essa funcao vai checar se hoje a meta foi batica caso nao o botao continua vermelho caso sim verifica se ja foi upado caso nao tenha sido ele upa e modifica para upado e fica verde
    
}
