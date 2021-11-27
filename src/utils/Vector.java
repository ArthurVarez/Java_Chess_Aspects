package utils;

public class Vector {
    public Vector(int X, int Y) {
        x = X;
        y = Y;
    }

    public String toString() {
        return "Vector[" + x + "][" + y + "]";
    }
    public int x = 0;
    public int y = 0;
}