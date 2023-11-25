import mysql.connector

# Replace with your MySQL server's host, username, password, and database name
db = mysql.connector.connect(
    host="10.42.0.108",
    user="root",
    password="root",
    database="bookstore"
)

cursor = db.cursor()
cursor.execute("SELECT * FROM your_table_name")
result = cursor.fetchall()
db.commit()





def get_books():
    cursor = db.cursor(dictionary=True)  # Use dictionary cursor for named access
    cursor.execute("SELECT * FROM books")
    books = cursor.fetchall()
    cursor.close()
    return books



def add_customer(name, email, password, address):
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())
    cursor = db.cursor()
    cursor.execute("INSERT INTO customers (name, email, password, address) VALUES (%s, %s, %s, %s)", (name, email, hashed_password, address))
    db.commit()
    cursor.close()


def create_order(customer_id, book_details):
    cursor = db.cursor()
    cursor.execute("INSERT INTO orders (customer_id, order_date) VALUES (%s, CURDATE())", (customer_id,))
    order_id = cursor.lastrowid  # Get the ID of the last inserted order
    db.commit()

    for book_id, quantity in book_details:
        cursor.execute("INSERT INTO order_details (order_id, book_id, quantity) VALUES (%s, %s, %s)",
                       (order_id, book_id, quantity))

    db.commit()
    cursor.close()



def update_inventory(order_id):
    cursor = db.cursor()
    cursor.execute("""
        UPDATE inventory
        JOIN order_details ON inventory.book_id = order_details.book_id
        SET inventory.quantity = inventory.quantity - order_details.quantity
        WHERE order_details.order_id = %s
    """, (order_id,))
    db.commit()
    cursor.close()
