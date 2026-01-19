// ボールクラス - 水中での物理演算を持つ
class Ball {
  float x, y;           // 位置
  float vy;             // Y方向の速度
  float diameter;       // 直径
  color ballColor;      // 色
  float gravity;        // 重力加速度（水中なので遅め）
  float flowStrength;   // 水流の影響を受ける強度
  boolean isActive;     // 画面内にあるかどうか
  
  // 成長アニメーション用
  float initialDiameter;     // 初期直径
  float targetDiameter;      // 目標直径
  boolean hasLanded;         // 着地したかどうか
  boolean isGrowing;         // 成長中かどうか
  
  // コンストラクタ
  Ball(float startX) {
    this.x = startX;
    this.y = 0;
    this.vy = 0;
    this.initialDiameter = 45;
    this.diameter = this.initialDiameter;
    this.targetDiameter = 150;  // 成長後の目標サイズ
    this.ballColor = color(100, 200, 100, 200);
    this.gravity = 0.15;  // 水中を想定した遅めの重力
    this.flowStrength = 2.0;  // ボールは水流の影響を受けやすい
    this.isActive = true;
    this.hasLanded = false;
    this.isGrowing = false;
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
      
      // 跳ね返りが小さくなったら停止して成長開始
      if (abs(vy) < 0.5) {
        vy = 0;
        
        // まだ着地していなければ、着地として成長アニメーション開始
        if (!hasLanded) {
          hasLanded = true;
          startGrowth();
        }
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
  
  // 成長アニメーションを開始
  void startGrowth() {
    if (!isGrowing) {
      isGrowing = true;
      // Aniライブラリを使って滑らかに成長
      // 3秒かけてtargetDiameterまで成長、イージングはELASTIC_OUTで自然な動き
      Ani.to(this, 3.0, "diameter", targetDiameter, Ani.ELASTIC_OUT);
    }
  }
}
