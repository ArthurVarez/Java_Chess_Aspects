package MyAspects;

import utils.MoveValidator;
import edu.uqac.aop.chess.agent.Move;
import edu.uqac.aop.chess.agent.HumanPlayer;
import edu.uqac.aop.chess.Board;

public aspect ValidateMoveAspect {
    private pointcut validateMove() :
        execution(boolean edu.uqac.aop.chess.agent.HumanPlayer.makeMove(Move));

    boolean around(Object p, HumanPlayer player, Move move) : validateMove() && this(p) && target(player) && args(move) {
        Board board = null;

        try {
            board = (Board)p.getClass().getSuperclass().getDeclaredField("playGround").get(p);
        } catch(Exception e) {
            e.printStackTrace();
            return false;
        }
        MoveValidator mv = new MoveValidator(board, move, player);

        if (mv.isValidSpot() &&
            mv.isPlayerPiece() &&
            mv.isValidMovement() &&
            mv.isInBoard() &&
            mv.notComingOnAlly() &&
            mv.notGoingThroughOtherPiece()) {
                return proceed(p, player, move);
            }
        return false;
    }
}