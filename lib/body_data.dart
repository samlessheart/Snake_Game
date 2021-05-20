class BodyData {
  double dataX;
  double dataY;
  double lastX;
  double lastY;
  BodyData next;
  BodyData(double dataX, double dataY) {
    this.dataX = dataX;
    this.dataY = dataY;
  }

  void headMove(direction) {
    if (direction == 'down') {
      this.dataY += 0.02;
      if (this.dataY > 1) {
        this.dataY = -1;
      }
    } else if (direction == 'up') {
      this.dataY -= 0.02;
      if (this.dataY < -1) {
        this.dataY = 1;
      }
    } else if (direction == 'left') {
      this.dataX -= 0.02;
      if (this.dataX < -1) {
        this.dataX = 1;
      }
    } else if (direction == 'right') {
      this.dataX += 0.02;
      if (this.dataX > 1) {
        this.dataX = -1;
      }
    }
  }

  void moveBody() {
    if (this.next != null) {
      this.next.dataX = this.dataX;
      this.next.dataY = this.dataY;
    }
  }

  void moveData() {
    if (this.next != null) {
      this.lastX = this.dataX;
      this.lastY = this.dataY;
      this.next.moveData();
    }
  }

  void movingBody(){
    if (this.next != null) {
      this.next.dataX = this.lastX;
      this.next.dataY = this.lastY;
      this.next.movingBody();
    }
  }
}
