
public struct MoveCommand {
  public var gameboard: Gameboard
  
  public var gameboardView: GameboardView
  
  public var player : Player
  
  public var position : GameboardPosition

  public func execute(completion: (() -> Void)? = nil) {
    gameboard.setPlayer(player, at: position)
    
    gameboardView.placeMarkView(player.markViewPrototype.copy(), at: position, animated: true, completion: completion)
  }
  
}
