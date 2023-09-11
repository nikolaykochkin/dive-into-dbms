# encoding: utf-8
import psycopg2 as pg_driver

# Postgres, запущенный в докере, не требует пароля, если клиент находится на localhost
db = pg_driver.connect(user="postgres", host="localhost")
cur = db.cursor()


def fun1(commander_id):
    result = []
    cur.execute("SELECT commander_id, spacecraft_id, start_date FROM Flight")
    for flight in cur.fetchall():
        if flight[0] != commander_id:
            continue
        cur.execute("SELECT id, name FROM Spacecraft")
        for spacecraft in cur.fetchall():
            if spacecraft[0] == flight[1]:
                result.append((spacecraft, flight))  # добавляем в результат пару
    return result


def fun2(commander_id):
    result = []
    for spacecraft, flight in fun1(commander_id):
        cur.execute("SELECT id, name FROM Commander")
        for cmndr in cur.fetchall():
            if cmndr[0] == flight[0]:
                result.append((cmndr[1], spacecraft[1], flight[2]))  # добавляем в результат тройку
    return result


for row in fun2(6):
    print(row)
