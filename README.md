YOLOv5で並列に物体検出するイントラ（自分）用マイクロサービス（になる予定）
========================================================================

概要
----

* YOLOv5は動いた模様
* FIXME: Python公式イメージは起動時にPython対話シェルが立ち上がっちゃう？
* TODO: Flask + マルチスレッドで並列に検出してくれることを期待している
* TODO: LAN内で自分用に使うからFlaskのWebサーバで良しとする
* TODO: サービス化してコンテナ起動と同時に使えるようにする

使い方
------

### ビルド-起動する
```
$ docker-compose up --build
```

### 別ターミナルでbash起動
```
$ docker-compose exec python3 bash
```

### サンプル実行
```
# python sample.py
Using cache found in /root/.cache/torch/hub/ultralytics_yolov5_master
YOLOv5 � 2021-7-12 torch 1.9.0+cu102 CPU

Fusing layers...
/usr/local/lib/python3.9/site-packages/torch/nn/functional.py:718: UserWarning:Named tensors and all their associated APIs are an experimental feature and subject to change. Please do not use them for anything important until they are released as stable. (Triggered internally at  /pytorch/c10/core/TensorImpl.h:1156.)
  return torch.max_pool2d(input, kernel_size, stride, padding, dilation, ceil_mode)
Model Summary: 224 layers, 7266973 parameters, 0 gradients
Adding AutoShape...
image 1/1: 720x1280 2 persons, 2 ties
Speed: 431.4ms pre-process, 80.8ms inference, 1.2ms NMS per image at shape (1, 3, 384, 640)
```
