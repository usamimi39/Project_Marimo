// 入力管理 - アクションの検知を関数で管理
// 将来的に入力方法を変更する場合はこのファイルのみ修正すればOK

// アクションが発生したかどうかをチェック
boolean checkActionTriggered() {
  // 現在はスペースキーを使用
  // 将来的に変更する場合はこの関数内のみ修正
  return checkSpaceKeyPressed();
}

// スペースキーが押されたかチェック（内部関数）
boolean checkSpaceKeyPressed() {
  if (keyPressed && key == ' ') {
    return true;
  }
  return false;
}

// 将来的に他の入力方法を追加する場合の例：
/*
boolean checkMouseClicked() {
  if (mousePressed) {
    return true;
  }
  return false;
}

boolean checkSensorTriggered() {
  // センサーの値をチェック
  return false;
}
*/
