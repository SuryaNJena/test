class button {

    int x_cor;
    int y_cor;
    int wideX = 70;
    int longY = 100;
    boolean tog = false;
    

    button( int x_pla,int y_pla) {
        x_cor = x_pla;
        y_cor = y_pla;

    }

    void display() {

        strokeWeight(8);
        stroke(255);
        fill(0, 255, 0); //green color
        rect(x_cor, y_cor, wideX, longY);
        //displays text "VACANT" when button is green
        fill(255,255,255);
        textSize(15);
        text("VACANT", x_cor+10, y_cor+10, 60, 35);
    }

    void update_button() {

        strokeWeight(8);
        stroke(255);
        fill(255, 255, 0); //yellow color
        rect(x_cor, y_cor, wideX, longY);
        //displays text "BOOKED" when button is yellow
        fill(0);
        textSize(13);
        text("BOOKED", x_cor+10, y_cor+10, 50, 30);
    }

    void labels(int k,int l,int m) {
        int q=0;
        q=l*2+m*1;
        textSize(16);
        fill(255);
        text("F"+k+"S"+q, x_cor+10, y_cor-10);
    }

}