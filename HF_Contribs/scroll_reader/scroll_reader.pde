int f_no;
int i,j,k;


String st1 = null;
String st2 = null;

color base;
color hover;
color tempA,tempB;


button [][][] b = new button [4][2][2];

void setup() {
    size(600,400);
    f_no = 0;
    for (i=0; i<4; i++) {
        for (j=0; j<2; j++) {
            for(k=0;k<2;k++) {
                b[i][j][k]= new button(50+(k*100),100+(j*130));


            }
        }
    }
    hover = color(205);
    base = color(255);
    tempA = base;
    tempB = base;
}

void draw() {
    background(0);
    up_arrow_button(tempA);
    down_arrow_button(tempB);

    if (evaluate_up_arrow(mouseX,mouseY)) {

        tempA = hover;
        tempB = base;
    }
    else if (evaluate_down_arrow(mouseX,mouseY)) {
        tempA = base;
        tempB = hover;
    
    }
    else {
        tempA = base;
        tempB = base;
    }

    
        for (j=0; j<2; j++) {
            for(k=0;k<2;k++) {
                if(b[f_no][j][k].tog) {
                    b[f_no][j][k].update_button();
                    b[f_no][j][k].labels(f_no,j,k);

                }
                else {
                    b[f_no][j][k].display();
                    b[f_no][j][k].labels(f_no,j,k);
                }


            }
        }
    
    update_floor(f_no);
    show_floor_data(st1,st2);
}

void mousePressed() {
    if (dist(mouseX,mouseY,500,40)<=25) {
        f_no++;
        if (f_no>=3) {
            f_no = 3;
        }
    }
    else if (dist(mouseX,mouseY,500,100)<=25) {
        f_no--;
        if (f_no<0) {
            f_no = 0;
        }
    }

    for (i=0; i<4;i++) {
        for (j=0; j<2; j++) {
            for(k=0;k<2;k++) {
                if ((mouseX > b[i][j][k].x_cor) &&
                (mouseX <= (b[i][j][k].x_cor+b[i][j][k].wideX)) &&
                (mouseY > b[i][j][k].y_cor) &&
                (mouseY <= (b[i][j][k].y_cor+b[i][j][k].longY))) {
                    if (i == f_no) {
                        b[f_no][j][k].tog = !b[f_no][j][k].tog;
                    }
                    
                }


            }
        }
    }
}

void up_arrow_button(color c) {
    //the-ring
    strokeWeight(5);
    stroke(255, 0, 0);
    fill(c);
    ellipse(500, 40, 50, 50);
    //the arrow pointing up
    strokeWeight(8);
    stroke(255, 0, 0);
    line(490, 50, 500, 30);
    line(500, 30, 510, 50);

}
void down_arrow_button(color c) {
    //the-ring
    strokeWeight(5);
    stroke(255, 0, 0);
    fill(c);
    ellipse(500, 100, 50, 50);
    //the arrow pointing down
    strokeWeight(8);
    stroke(255, 0, 0);
    line(490, 90, 500, 110);
    line(500, 110, 510, 90);

}

void update_floor(int p) {
    if (p==0) {
        st1 = "GND";
        st2 = " OUT OF 3";
    }
    else if (p==1) {
        st1 = "1ST";
        st2 = " OUT OF 3";
    }
    else if (p==2) {
        st1 = "2ND";
        st2 = " OUT OF 3";
    }
    else if (p==3) {
        st1 = "3RD";
        st2 = " OUT OF 3";
    }
    else {
        st1 = "NO SUCH";
        st2 = " EXISTS";
    }



}

void show_floor_data(String k,String l) {

    textSize(28);
    text(k+" FLOOR"+ l,110,30);

}

boolean evaluate_up_arrow(int m,int n) {
    if (dist(m, n, 500, 40)<=25) {
        return true;
        
    }
    else {
        return false;
    }
}

boolean evaluate_down_arrow(int m,int n) {
    if(dist(m, n, 500, 100)<=25) {
        return true;
    }
    else {
        return false;
    }
}
