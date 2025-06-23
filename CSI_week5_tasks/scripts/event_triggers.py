from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
from sqlalchemy import create_engine
import pandas as pd
import time
import os

def get_engine():
    return create_engine(
        "mssql+pyodbc://localhost/master?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes"
    )

class FileHandler(FileSystemEventHandler):
    def on_created(self, event):
        if event.src_path.endswith(".csv"):
            print(f"New CSV detected: {event.src_path}")

            engine = get_engine()

            try:
                df = pd.read_csv(event.src_path)
                table_name = os.path.splitext(os.path.basename(event.src_path))[0]

                # Load into database
                df.to_sql(table_name, engine, if_exists="replace", index=False)
                print(f"Uploaded {len(df)} rows to table: {table_name}")
            except Exception as e:
                print(f"Error processing file: {e}")

watch_path = "data/input_folder"  # Change to your folder path
observer = Observer()
observer.schedule(FileHandler(), path=watch_path, recursive=False)
observer.start()

try:
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    observer.stop()
observer.join()
