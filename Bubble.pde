// 泡クラス - 画面下から上に上昇する
class Bubble {
  float x, y;           // 位置
  float vy;             // Y方向の速度（上昇）
  float diameter;       // 直径
  float flowStrength;   // 水流の影響を受ける強度
  color bubbleColor;    // 色
  boolean isActive;     // 画面内にあるかどうか
  
  // コンストラクタ
  Bubble(float startX, float startY) {
    this.x = startX;
    this.y = startY;
    this.diameter = random(5, 20);  // ランダムなサイズ
    this.vy = random(-1.5, -3.0);   // 上昇速度（負の値で上向き）- 軽く速く上昇
    this.flowStrength = random(0.5, 1.5);  // 泡は軽いのでより流れの影響を受ける
    this.bubbleColor = color(255, 255, 255, 150);  // 半透明の白
    this.isActive = true;
  }
  
  // 更新処理
  void update() {
    if (!isActive) return;
    
    // 上昇
    y += vy;
    
    // 水の流れによるX方向の動き
    float flowX = getWaterFlowX(y, flowStrength);
    x += flowX;
    
    // 画面端の処理（循環させる）
    if (x < 0) {
      x = width;
    } else if (x > width) {
      x = 0;
    }
    
    // 画面上部に到達したら非アクティブに
    if (y + diameter/2 < 0) {
      isActive = false;
    }
  }
  
  // 描画処理
  void display() {
    if (!isActive) return;
    
    // 泡の描画
    noFill();
    stroke(bubbleColor);
    strokeWeight(2);
    ellipse(x, y, diameter, diameter);
    
    // 泡の光沢効果
    fill(255, 255, 255, 100);
    noStroke();
    ellipse(x - diameter/4, y - diameter/4, diameter/3, diameter/3);
  }
  
  // アクティブ状態を取得
  boolean isActive() {
    return isActive;
  }
}
