YOLOv5で並列に物体検出するイントラ（自分）用マイクロサービス（になる予定）
========================================================================

概要
----

* YOLOv5は動いた模様
* TODO: Flask + マルチスレッドで並列に検出してくれることを期待している*
* TODO: 下記のエラーの改善
  * ネットワークの遅延なのか、detectionの遅延なのか
  * 呼び出し側が矢継ぎ早だからか

> ERROR: An HTTP request took too long to complete. Retry with --verbose to obtain debug information.
> If you encounter this issue regularly because of slow network conditions, consider setting COMPOSE_HTTP_TIMEOUT to a higher value (current value: 60).

使い方
------

### ビルド-起動する
```
#$ docker system prune -f
$ docker-compose up --build
```

### サンプル実行
```
# healthcheck
$ curl http://localhost:8010/
YOLOv5 my micro service is running.
# label list
$ curl http://localhost:8010/names
TODO: 
# detection - sample file from Unsplash(https://unsplash.com/)
$ curl -X POST -F file=@sampleimage.jpg http://localhost:8010/detection
[
  {
    "label": "elephant",
    "p1": {
      "x": 239.77001953125,
      "y": 159.95553588867188
    },
    "p2": {
      "x": 382.79400634765625,
      "y": 378.6675109863281
    },
    "score": 0.9328093528747559
  },
  {
    "label": "person",
    "p1": {
      "x": 462.5768127441406,
      "y": 183.0345458984375
    },
    "p2": {
      "x": 483.7295837402344,
      "y": 209.35955810546875
    },
    "score": 0.793636679649353
  },
  {
    "label": "truck",
    "p1": {
      "x": 405.8444519042969,
      "y": 207.40274047851562
    },
    "p2": {
      "x": 531.7650756835938,
      "y": 301.3897399902344
    },
    "score": 0.7933353781700134
  },
# 後略
```

### トラブルシュート

下記のエラーが出てコンテナが停止する場合の対処方法（暫定）

> ERROR: An HTTP request took too long to complete. Retry with --verbose to obtain debug information.
> If you encounter this issue regularly because of slow network conditions, consider setting COMPOSE_HTTP_TIMEOUT to a higher value (current value: 60).

```
export DOCKER_CLIENT_TIMEOUT=120
export COMPOSE_HTTP_TIMEOUT=120
```