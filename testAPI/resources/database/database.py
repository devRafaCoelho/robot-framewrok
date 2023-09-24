from robot.api.deco import keyword
from psycopg2 import connect, sql
import bcrypt

db = connect(
    host="localhost",
    port="5432",
    database="records_system_db",
    user="postgres",
    password="123456"
)


@keyword('Insert user into database')
def insertUser(user):
    cursor = db.cursor()

    salt = bcrypt.gensalt(10)
    password = user['password'].encode('utf-8')
    encryptedPassword = bcrypt.hashpw(password, salt).decode('utf-8')

    query = sql.SQL(
        'INSERT INTO "User" ("firstName", "lastName", email, cpf, phone, password) VALUES (%s, %s, %s, %s, %s, %s)')

    userData = (
        user['firstName'],
        user['lastName'],
        user['email'],
        user['cpf'],
        user['phone'],
        encryptedPassword
    )

    cursor.execute(query, userData)
    db.commit()
    cursor.close()


@keyword('Remove user from database')
def removeUser(type, data):
    cursor = db.cursor()

    query = sql.SQL('DELETE FROM "User" WHERE {} = %s').format(
        sql.Identifier(type))

    cursor.execute(query, (data,))
    db.commit()

    cursor.close()


def closeConnection():
    db.close()


# @keyword('Clean user from database')
# def clean_user(email):
#     cursor = db.cursor()

#     query = sql.SQL('SELECT * FROM "User" WHERE email = %s')
#     userExists = cursor.execute(query, (email,))

#     if (userExists):
#         query = sql.SQL('DELETE FROM "User" WHERE email = %s')
#         cursor.execute(query, (email,))
#         db.commit()

#     cursor.close()
