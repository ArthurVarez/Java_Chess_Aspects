package MyAspects;

import utils.Logger;
import edu.uqac.aop.chess.Board;
import edu.uqac.aop.chess.agent.Move;

public aspect LoggerAspect {

    private Logger _logger = new Logger("../output.txt");
    private int _turn = 0;

    private pointcut printMain() :
        execution(void edu.uqac.aop.chess.Chess.main(..));

    before() : printMain() {
        _logger.addLog("Program start");
    }

    after() : printMain() {
        _logger.addLog("Program end");
    }

    private pointcut printMove() :
        execution(void edu.uqac.aop.chess.Board.movePiece(Move));

    void around(Board board, Move move) : printMove() && target(board) && args(move) {
        ++_turn;
        _logger.addLog("Turn [" + _turn + "]: The piece [" + board.getGrid()[move.xI][move.yI].getPiece() + "] moved [" + move + "]");
        proceed(board, move);
    }
}