import requests as rq
import json
import os

class CallAPI:
    
    def __init__(self):
        pass
    
    def getJSON(self, url):
        response = rq.get(url)
        data = response.json()
        print("Worked!")
        return data

    def saveLocal(self, myjson, filename, directoryName):
        os.makedirs(directoryName, exist_ok=True)
        full_path = os.path.join(directoryName, filename)
        
        with open(full_path, "w", encoding="utf-8") as f:
            json.dump(myjson, f, ensure_ascii=False, indent=4)
        print(f"JSON saved to {filename}")

    

    