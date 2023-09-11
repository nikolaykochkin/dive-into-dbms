# encoding: utf-8
import psycopg2


def get_connection():
    con = psycopg2.connect(user="postgres", host="localhost")
    return con


# общий класс для доступа к данным. Держит подключение.
class DAO(object):
    def __init__(self):
        self.con = get_connection()

    def close(self):
        self.con.close()


# Класс, инкапсулирующий данные полёта
class Flight(DAO):
    def __init__(self, id):
        super(Flight, self).__init__()
        self.id = id

    # Возвращает идентификатор капитана, выполняющего полёт
    def get_commander(self):
        cur = self.con.cursor()
        cur.execute("SELECT commander_id FROM Flight WHERE id=%s", (self.id,))
        return cur.fetchone()[0]

    # Назначает нового капитана на данный полёт.
    # Конструкция try-except для целей задания не существенна.
    def set_commander(self, commander_id):
        cur = self.con.cursor()
        try:
            cur.execute("UPDATE Flight SET commander_id=%s WHERE id=%s", (commander_id, self.id))
        except psycopg2.IntegrityError:
            pass


# Класс, инкапсулирующий данные планеты
class Planet(DAO):
    def __init__(self, id):
        super(Planet, self).__init__()
        self.id = id

    # Возвращает список экземпляров класса Flight, соответствующих полётам на эту планету
    def get_flights(self):
        result = []
        cur = self.con.cursor()
        cur.execute(
            "SELECT id FROM Flight WHERE planet_id=%s", (self.id,))
        for f in cur.fetchall():
            result.append(Flight(f[0]))
        return result

    # Статический метод, возвращающий список экземпляров класса Planet,
    # соответствующий планетам в заданной галактике
    @staticmethod
    def find_all_by_galaxy(galaxy_num):
        result = []
        con = get_connection()
        cur = con.cursor()
        cur.execute("SELECT id FROM Planet WHERE galaxy=%s", (galaxy_num,))
        for p in cur.fetchall():
            result.append(Planet(p[0]))
        con.close()
        return result


# Основная 'бизнес-логика'
planets = Planet.find_all_by_galaxy(2)
for p in planets:
    flights = p.get_flights()
    for f in flights:
        if f.get_commander() == 1:
            f.set_commander(2)
    for f in flights:
        f.close()

for p in planets:
    p.close()
