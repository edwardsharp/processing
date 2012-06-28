import android.view.MotionEvent;
float x1,y1,x2,y2,press1,press2;
int pointNum;
void touchSetup() {
//size(displayWidth, displayHeight);
stroke(0);
}
void touchDraw() {
fill(press1*200,0,0);
ellipse(x1,y1,press1*300,press1*300);
fill(0,press2*200,0);
ellipse(x2,y2,press2*300,press2*300);
}

boolean surfaceTouchEvent(MotionEvent event) {
pointNum=event.getPointerCount();
switch (event.getAction() & MotionEvent.ACTION_MASK) {
case MotionEvent.ACTION_POINTER_DOWN:
// User is pressing down another finger.
break;
case MotionEvent.ACTION_POINTER_UP:
// User is released one of the fingers.
break;
case MotionEvent.ACTION_MOVE:
x1=event.getX(0);x2=event.getX(1);
y1=event.getY(0);y2=event.getY(1);
press1=event.getSize(0);
press2=event.getSize(1);
break;
}
return super.surfaceTouchEvent(event);
}
