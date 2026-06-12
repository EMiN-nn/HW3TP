import csv
import random
import os
import sys

NUM_ROWS = 100
COLUMNS = ["AGE", "WEIGHT_KG", "UPPER_CHEST_MAX", "GYM_CLUB"]

def generate_row():
    return {
        "AGE": random.randint(16, 60),
        "WEIGHT_KG": round(random.uniform(50.0, 110.0), 2),
        "UPPER_CHEST_MAX": random.randint(40, 140),
        "GYM_CLUB": random.choice(["DDX Fitness", "Kometa.fit", "Crocus Fitness", "UFC Gym"]),
    }

OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/data"
OUTPUT_FILE = os.path.join(OUTPUT_DIR, "data.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

rows = [generate_row() for _ in range(NUM_ROWS)]

with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=COLUMNS)
    writer.writeheader()
    writer.writerows(rows)