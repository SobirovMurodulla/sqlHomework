import pyodbc
con_string = "Driver={SQL Server};Server=Zenith\SQLEXPRESS;Database=class2Homework;Trusted_Connection=yes;"
conn = pyodbc.connect(con_string)
cursor = conn.cursor()
cursor.execute("SELECT * FROM photos")
row = cursor.fetchone()
id, photo = row
with open("photo.png", "wb") as f:
    f.write(photo)
