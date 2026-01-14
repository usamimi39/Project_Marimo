// ボールのリストを管理
ArrayList<Ball> balls;
boolean lastActionState = false;  // 前フレームのアクション状態

void setup() {
  fullScreen();
  balls = new ArrayList<Ball>();
}

void draw() {
  // 水中を想定した背景色（青緑系）
  background(100, 180, 200);
  
  // アクションがトリガーされたか確認（連続発生を防ぐ）
  boolean currentActionState = checkActionTriggered();
  if (currentActionState && !lastActionState) {
    // 新しいボールを追加（ランダムなX位置から）
    balls.add(new Ball(random(50, width - 50)));
  }
  lastActionState = currentActionState;
  
  // すべてのボールを更新・描画
  for (int i = balls.size() - 1; i >= 0; i--) {
    Ball ball = balls.get(i);
    ball.update();
    ball.display();
    
    // 非アクティブなボールを削除
    if (!ball.isActive()) {
      balls.remove(i);
    }
  }
  
  // デバッグ情報（オプション）
  fill(255);
  textAlign(LEFT, TOP);
  text("Active balls: " + balls.size(), 10, 10);
  text("Press SPACE to drop a ball", 10, 30);
}
