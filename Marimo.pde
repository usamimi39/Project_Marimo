// ボールのリストを管理
ArrayList<Ball> balls;
ArrayList<Bubble> bubbles;
boolean lastActionState = false;  // 前フレームのアクション状態
int bubbleSpawnTimer = 0;         // 泡の生成タイマー
int bubbleSpawnInterval = 10;     // 泡の生成間隔（フレーム）

void setup() {
  fullScreen();
  balls = new ArrayList<Ball>();
  bubbles = new ArrayList<Bubble>();
  
  // 水流の初期化
  initWaterFlow();
}

void draw() {
  // 水中を想定した背景色（青緑系）
  background(100, 180, 200);
  
  // 水流を更新
  updateWaterFlow();
  
  // 泡を定期的に生成
  bubbleSpawnTimer++;
  if (bubbleSpawnTimer >= bubbleSpawnInterval) {
    // 画面下部からランダムな位置に泡を生成
    bubbles.add(new Bubble(random(0, width), height));
    bubbleSpawnTimer = 0;
  }
  
  // すべての泡を更新・描画（ボールより先に描画して背景に）
  for (int i = bubbles.size() - 1; i >= 0; i--) {
    Bubble bubble = bubbles.get(i);
    bubble.update();
    bubble.display();
    
    // 非アクティブな泡を削除
    if (!bubble.isActive()) {
      bubbles.remove(i);
    }
  }
  
  // アクションがトリガーされたか確認（連続発生を防ぐ）
  boolean currentActionState = checkActionTriggered();
  if (currentActionState && !lastActionState) {
    // 新しいボールを追加（画面中央から）
    balls.add(new Ball(width / 2));
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
  text("Active bubbles: " + bubbles.size(), 10, 30);
  text("Press SPACE to drop a ball", 10, 50);
}
