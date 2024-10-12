from contextlib import closing
from fastapi import *
from fastapi.middleware.cors import CORSMiddleware
from mysql.connector import *
import random
import string

from starlette.staticfiles import StaticFiles
print("flag{nice start}")
app = FastAPI()


origins = ["*"]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def mysql_conn():
    return connect(user='root', password='admin', host='127.0.0.1', database='restaurant1', auth_plugin='mysql_native_password')

def userInfo(token):
    with closing(mysql_conn()) as con:
        sql = con.cursor()
        sql.execute(f"SELECT user, type FROM tokens WHERE token = '{token}'")
        return list(sql.fetchone())

@app.post("/login")
async def login(username = Form(), password = Form(), position = Form()):
    with closing(mysql_conn()) as con:
        sql = con.cursor()
        characters = string.ascii_letters + string.digits
        token = ''.join(random.choice(characters) for _ in range(32))
        match (position):
            case "Повар":
                sql.execute(f"SELECT Cook_ID FROM passcook WHERE login = '{username}' and PassCook = '{password}';")
                data = sql.fetchone()
                if data is not None:
                    sql.execute(f"INSERT INTO tokens SET token = '{token}', user='{list(data)[0]}', type = 'Повар'")
                    con.commit()
                    return {"token": token}

            case "Официант":
                sql.execute(f"SELECT Waiter_ID FROM passwaiter WHERE login = '{username}' and PassWaiter = '{password}';")
                data = sql.fetchone()
                if data is not None:
                    sql.execute(f"INSERT INTO tokens SET token = '{token}', user='{list(data)[0]}', type = 'Официант'")
                    con.commit()
                    return {"token": token}
    raise HTTPException(status_code=401)


@app.get("/getInfoLk")
async def getInfoLk(token: str):
    with closing(mysql_conn()) as con:
        sql = con.cursor()
        pos_sql = userInfo(token)
        infoUser = []
        match(pos_sql[1]):
            case "Повар":
                sql.execute(f"SELECT Cook_Name, Cook_ID FROM cook WHERE Cook_ID = '{pos_sql[0]}'")
                infoUser = list(sql.fetchone())
            case "Официант":
                sql.execute(f"SELECT WaiterName, Waiter_ID FROM waiter WHERE Waiter_ID = '{pos_sql[0]}'")
                infoUser = list(sql.fetchone())
        return {"fio": infoUser[0], "id": infoUser[1], "position": pos_sql[1]}

@app.post("/cook")
async def add(Cook_ID : int, PassCook : str):
    with closing(mysql_conn()) as con:
        sql = con.cursor()
        try:
            sql.execute(f"INSERT INTO passcook(Cook_ID, PassCook) values ('{Cook_ID}','{PassCook}');")
            con.commit()
            return {"message": "All right, baby!"}
        except:
            raise HTTPException(status_code=500)

@app.post("/waiter")
async def add(Waiter_ID : int, PassWaiter : str):
    with closing(mysql_conn()) as con:
        sql = con.cursor()
        try:
            sql.execute(f"INSERT INTO passwaiter(Waiter_ID, PassWaiter) values ('{Waiter_ID}','{PassWaiter}');")
            con.commit()
            return {"message": "All right, baby!"}
        except:
            raise HTTPException(status_code=500)


@app.post("/order")
async def order(fullName = Form(), address = Form()):
    with closing(mysql_conn()) as con:
        sql = con.cursor()
        try:
            sql.execute(f"INSERT INTO client (Client_Full_Name, Address) VALUES ('{fullName}', '{address}');")
            sql.execute(f"INSERT INTO order_table (Client_ID, Waiter_ID, Cook_ID, Stat) SELECT c.Client_ID, w.Waiter_ID, k.Cook_ID, 'ready' FROM (SELECT Client_ID FROM client ORDER BY Client_ID DESC LIMIT 1) AS c, (SELECT Waiter_ID FROM waiter ORDER BY Waiter_ID DESC LIMIT 1) AS w, (SELECT Cook_ID FROM cook ORDER BY Cook_ID DESC LIMIT 1) AS k;")
            con.commit()
            return {"message": "Order in proccess"}
        except:
            raise HTTPException(status_code=500)





