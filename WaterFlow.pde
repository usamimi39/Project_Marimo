// 水の流れを管理するクラスと関数
// パーリンノイズとsinカーブを組み合わせて自然な水の流れを表現

class WaterFlow {
  float noiseScale;      // ノイズのスケール
  float timeOffset;      // 時間のオフセット
  float baseFlow;        // 基本的な流れの強さ
  
  WaterFlow() {
    this.noiseScale = 0.001;
    this.timeOffset = 0;
    this.baseFlow = 1.0;
  }
  
  // 時間を進める
  void update() {
    timeOffset += 0.01;
  }
  
  // 指定位置での水の流れ（X方向の力）を計算
  // y: Y座標
  // strength: 流れの強度（0.0-1.0の範囲を推奨）
  float getFlowAt(float y, float strength) {
    // パーリンノイズで自然な変動を作る
    float noiseValue = noise(y * noiseScale, timeOffset);
    
    // -1から1の範囲に変換
    float flowX = (noiseValue - 0.5) * 2.0;
    
    // sinカーブを加えてより複雑な動きに
    float sinWave = sin(y * 0.005 + timeOffset * 2);
    flowX += sinWave * 0.3;
    
    // 強度を適用
    flowX *= strength * baseFlow;
    
    return flowX;
  }
  
  // 基本的な流れの強さを設定
  void setBaseFlow(float flow) {
    this.baseFlow = flow;
  }
}

// グローバルな水流インスタンス
WaterFlow waterFlow;

// 初期化関数（setupから呼び出す）
void initWaterFlow() {
  waterFlow = new WaterFlow();
}

// 更新関数（drawから呼び出す）
void updateWaterFlow() {
  if (waterFlow != null) {
    waterFlow.update();
  }
}

// 水の流れを取得する便利関数
float getWaterFlowX(float y, float strength) {
  if (waterFlow != null) {
    return waterFlow.getFlowAt(y, strength);
  }
  return 0;
}
