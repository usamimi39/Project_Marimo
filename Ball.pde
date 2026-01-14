// ボールクラス - 水中での物理演算を持つ
class Ball {
  float x, y;           // 位置
  float vy;             // Y方向の速度
  float diameter;       // 直径
  color ballColor;      // 色
  float gravity;        // 重力加速度（水中なので遅め）
  float flowStrength;   // 水流の影響を受ける強度
  boolean isActive;     // 画面内にあるかどうか
  
  // コンストラクタ
  Ball(float startX) {
    this.x = startX;
    this.y = 0;
    this.vy = 0;
    this.diameter = 30;
    this.ballColor = color(100, 200, 100, 200);
    this.gravity = 0.15;  // 水中を想定した遅めの重力
    this.flowStrength = 2.0;  // ボールは水流の影響を受けやすい
    this.isActive = true;
  }
  
  // 更新処理
  void update() {
    if (!isActive) return;
    
    // 重力を適用
    vy += gravity;
    
    // 水の抵抗を考慮した速度制限
    vy = constrain(vy, -10, 10);
    
    // 位置更新
    y += vy;
    
    // 水の流れによるX方向の動き
    float flowX = getWaterFlowX(y, flowStrength);
    x += flowX;
    
    // 画面端の処理
    x = constrain(x, diameter/2, width - diameter/2);
    
    // 底面との衝突判定と跳ね返り
    if (y + diameter/2 >= height) {
      y = height - diameter/2;  // 位置を底面に固定
      vy *= -0.7;  // 速度を反転して減衰（水中なので70%の反発）
      
      // 跳ね返りが小さくなったら停止
      if (abs(vy) < 0.5) {
        vy = 0;
      }
    }
  }
  
  // 描画処理
  void display() {
    if (!isActive) return;
    
    fill(ballColor);
    noStroke();
    ellipse(x, y, diameter, diameter);
  }
  
  // アクティブ状態を取得
  boolean isActive() {
    return isActive;
  }
}
