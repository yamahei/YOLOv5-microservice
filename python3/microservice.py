import torch
from flask import Flask, request, jsonify
import uuid
import os

model = torch.hub.load('ultralytics/yolov5', 'yolov5s')  # or yolov5m, yolov5x, custom
print(model.names)

def _detection(img):
    results = model(img)
    detects = []
    for result in results.xyxy[0]:
        p1x, p1y, p2x, p2y, score, _index = result
        index = _index.to(torch.int).item()
        detects.append({
            "p1": { "x": float(p1x), "y": float(p1y) },
            "p2": { "x": float(p2x), "y": float(p2y) },
            "score": float(score),
            "label": model.names[index]
        })
    return detects


app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = "/tmp"

@app.route('/')
def root():
    name = "YOLOv5 my micro service is running."
    return name

@app.route('/names')
def names():
    return jsonify(model.names)

@app.route('/detection', methods=['POST'])
def detection():
    if 'file' not in request.files:
        return "param 'file' not found.", 400

    file = request.files['file']
    filename = str(uuid.uuid1())
    filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    file.save(filepath)
    detected = _detection(filepath)

    os.remove(filepath)
    return jsonify(detected)

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=8010, threaded=True)
